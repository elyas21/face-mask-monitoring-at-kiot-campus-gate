import yaml
import torch.backends.cudnn as cudnn
import torch
import cv2
from pathlib import Path
import time
import shutil
import platform
import os
import argparse
from deep_sort_pytorch.deep_sort import DeepSort
from deep_sort_pytorch.utils.parser import get_config
from yolov5.utils.torch_utils import select_device, time_synchronized
from yolov5.utils.general import check_img_size, non_max_suppression, scale_coords
from yolov5.utils.datasets import LoadImages, LoadStreams
import sys
import config
# from ai.stream import streamImage

# from ai.stream import streamImage

sys.path.insert(0, './yolov5')

if isinstance('config/cam.yaml', str):  # *.yaml file
    with open('config/cam.yaml') as f:
        config.data_dict = yaml.load(f, Loader=yaml.SafeLoader)  # model dict

no_cams = len(config.data_dict['cams'])
config.mask_count = [[]] * no_cams
config.no_mask_count = [[]] * no_cams
config.total_mask_count = [0] * no_cams
config.total_no_mask_count = [0] * no_cams
config.no_cams = no_cams
from ai.utils import bbox_rel, compute_color_for_labels, draw_boxes, showImage, draw_lines, processResult
from ai.task.tasks import show_img

def detect(opt,  save_img=False, **kwargs):

    el_video = kwargs.get('video', None)

    out, source, weights, view_img, save_txt, imgsz = \
        opt.output, opt.source, opt.weights, opt.view_img, opt.save_txt, opt.img_size
    webcam = source == '0' or source.startswith(
        'rtsp') or source.startswith('http') or source.endswith('.txt')

    if os.path.exists(out):
        shutil.rmtree(out)  # delete output folder
    os.makedirs(out)  # make new output folder

    # vid SAVE
    fourcc = cv2.VideoWriter_fourcc(*'XVID')
    out_list = [cv2.VideoWriter(
        f'inference/output/output-{si}.avi', fourcc, 20.0, (640,  480)) for si in range(0, 3)]

    # initialize deepsort
    cfg = get_config()
    cfg.merge_from_file(opt.config_deepsort)
    deepsort = [DeepSort(cfg.DEEPSORT.REID_CKPT,
                         max_dist=cfg.DEEPSORT.MAX_DIST, min_confidence=cfg.DEEPSORT.MIN_CONFIDENCE,
                         nms_max_overlap=cfg.DEEPSORT.NMS_MAX_OVERLAP, max_iou_distance=cfg.DEEPSORT.MAX_IOU_DISTANCE,
                         max_age=cfg.DEEPSORT.MAX_AGE, n_init=cfg.DEEPSORT.N_INIT, nn_budget=cfg.DEEPSORT.NN_BUDGET,
                         use_cuda=True) for si in range(0, 3)]

    # Initialize
    device = select_device(opt.device)
    half = device.type != 'cpu'  # half precision only supported on CUDA

    # Load model
    model = torch.load(weights, map_location=device)[
        'model'].float()  # load to FP32
    model.to(device).eval()
    if half:
        model.half()  # to FP16

    # Set Dataloader
    vid_path, vid_writer = None, None
    if webcam:
        view_img = True
        cudnn.benchmark = True  # set True to speed up constant image size inference
        dataset = LoadStreams(source, img_size=imgsz)
    else:
        view_img = True
        save_img = True
        dataset = LoadImages(source, img_size=imgsz)

    # Get names and colors
    names = model.module.names if hasattr(model, 'module') else model.names

    # Run inference
    t0 = time.time()
    img = torch.zeros((1, 3, imgsz, imgsz), device=device)  # init img
    # run once
    _ = model(img.half() if half else img) if device.type != 'cpu' else None

    save_path = str(Path(out))
    txt_path = str(Path(out)) + '/results.txt'

    for frame_idx, (path, img, im0s, vid_cap) in enumerate(dataset):
        img = torch.from_numpy(img).to(device)
        img = img.half() if half else img.float()  # uint8 to fp16/32
        img /= 255.0  # 0 - 255 to 0.0 - 1.0
        if img.ndimension() == 3:
            img = img.unsqueeze(0)

        # Inference
        t1 = time_synchronized()
        pred = model(img, augment=opt.augment)[0]

        # Apply NMS
        pred = non_max_suppression(
            pred, opt.conf_thres, opt.iou_thres, agnostic=opt.agnostic_nms)
        t2 = time_synchronized()
        itt =0
        # Process detections
        for i, det in enumerate(pred):  # detections per image
            # print(f'                  i   {i}   {len(pred)} {det}')
            if webcam:  # batch_size >= 1
                p, s, im0 = path[i], '%g: ' % i, im0s[i].copy()
            else:
                p, s, im0 = path, '', im0s

            s += '%gx%g ' % img.shape[2:]  # print string
            save_path = str(Path(out) / Path(p).name)

            if det is not None and len(det):

                c_name = ''
                # Rescale boxes from img_size to im0 size
                det[:, :4] = scale_coords(
                    img.shape[2:], det[:, :4], im0.shape).round()

                # Print results
                # print(det)
                
                namess = [d[5].item() for d in det ]
                namess = [ names[int(n)] for n in namess]
    
                for c in det[:, -1].unique():
                    n = (det[:, -1] == c).sum()  # detections per class
                    s += '%g %ss, ' % (n, names[int(c)])  # add to string
                    # print(f'      cccc                 {n}           {names[int(c)]}')
                    c_name = names[int(c)]
                    # namess.append(c_name)
              
                # print(det)
                # print(namess)
                bbox_xywh = []
                confs = []

                for  *xyxy, conf, cls in det:
                    x_c, y_c, bbox_w, bbox_h = bbox_rel(*xyxy)
                    obj = [x_c, y_c, bbox_w, bbox_h]
                    bbox_xywh.append(obj)
                    # namess.append(names[int(newi)])
                    confs.append([conf.item()])
                    # newi =newi+1
                    # print(f'cls: {cls}')
                xywhs = torch.Tensor(bbox_xywh)
                confss = torch.Tensor(confs)

                # print(f'names len {len(names)}')
                # print(f'det len {len(det)}')
                # Pass detections to deepsort
                outputs = deepsort[i].update(xywhs, confss, im0)
                # draw boxes for visualization

                # Write MOT compliant results to file
                if save_txt and len(outputs) != 0:
                    for j, output in enumerate(outputs):
                        bbox_left = output[0]
                        bbox_top = output[1]
                        bbox_w = output[2]
                        bbox_h = output[3]
                        identity = output[-1]
                        with open(txt_path, 'a') as f:
                            f.write(('%g ' * 10 + '\n') % (frame_idx, identity, bbox_left,
                                                           bbox_top, bbox_w, bbox_h, -1, -1, -1, -1))  # label format
                # print(f'len outputs{len(outputs)} len names {len(namesss)}')
                # print(namesss)
                if len(outputs) > 0:
                    bbox_xyxy = outputs[:, :4]
                    identities = outputs[:, -1]

                    # draw_boxes(img, bbox, img_size, cam_src, namess=[], identities=None, c_name='', offset=(0, 0)):

                    draw_boxes(im0, bbox_xyxy, im0.shape, i, namess, identities, namess,(0, 0))
                    processResult(im0, bbox_xyxy, im0.shape,namess, i, c_name, identities)
                    # processResult(itt, outputs,bbox_xyxy, c_name, im0.shape,i, identities)
                    
            else:
                deepsort[i].increment_ages()

            # Print time (inference + NMS)
            # print('%sDone. (%.3fs)' % (s, t2 - t1))
            # Stream results
            if view_img:
                # draw lines
                draw_lines(im0, im0.shape, i)
                # write img
                out_list[i].write(im0)
                # show images
                # .delay(10,20)
                # result = show_img.delay(p, im0)
                # result.status
                # result.get()
                # stream images
                # streamImage(p, im0)
                show_img(p, im0)
    if save_txt or save_img:
        # print('Results saved to %s' % os.getcwd() + os.sep + out)
        if platform == 'darwin':  # MacOS
            os.system('open ' + save_path)

    # print('Done. (%.3fs)' % (time.time() - t0))
