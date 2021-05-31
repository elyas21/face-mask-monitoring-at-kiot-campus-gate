import cv2
import time
import imagezmq
import sys
import redis
import config



palette = (2 ** 11 - 1, 2 ** 15 - 1, 2 ** 20 - 1)

def bbox_rel(*xyxy):
    """" Calculates the relative bounding box from absolute pixel values. """
    bbox_left = min([xyxy[0].item(), xyxy[2].item()])
    bbox_top = min([xyxy[1].item(), xyxy[3].item()])
    bbox_w = abs(xyxy[0].item() - xyxy[2].item())
    bbox_h = abs(xyxy[1].item() - xyxy[3].item())
    x_c = (bbox_left + bbox_w / 2)
    y_c = (bbox_top + bbox_h / 2)
    w = bbox_w
    h = bbox_h
    return x_c, y_c, w, h


def compute_color_for_labels(label):
    """
    Simple function that adds fixed color depending on the class
    """
    color = [int((p * (label ** 2 - label + 1)) % 255) for p in palette]
    return tuple(color)


def draw_boxes(img, bbox, img_size, identities=None, c_name = '', offset=(0, 0)):
    for i, box in enumerate(bbox):
        x1, y1, x2, y2 = [int(i) for i in box]
        x1 += offset[0]
        x2 += offset[0]
        y1 += offset[1]
        y2 += offset[1]
        # box text and bar
        id = int(identities[i]) if identities is not None else 0
        color = compute_color_for_labels(id)
        label = '{}{:d}'.format("", id)
        label = f'{label} {c_name}'
        t_size = cv2.getTextSize(label, cv2.FONT_HERSHEY_PLAIN, 2, 2)[0]
        cv2.rectangle(img, (x1, y1), (x2, y2), color, 3)
        cv2.rectangle(
            img, (x1, y1), (x1 + t_size[0] + 3, y1 + t_size[1] + 4), color, -1)
        cv2.putText(img, label, (x1, y1 +
                                 t_size[1] + 4), cv2.FONT_HERSHEY_PLAIN, 2, [255, 255, 255], 2)

    return img

def draw_lines(img, img_size, cam_src):
    
    # DISPLAY COUNT
    no_mask_label = f'WITH OUT Mask {config.total_no_mask_count} {config.data_dict["cams"][0]["id"]}'
    mask_label = f'WITH Mask {config.total_mask_count}'
    cv2.putText(img, no_mask_label, (int(img_size[0] * .6), int(img_size[1] *.15) -5), cv2.FONT_HERSHEY_PLAIN, 2, [25, 25, 255], 2)
    cv2.putText(img, mask_label, (int(img_size[0] * .6), int(img_size[1] *.15) - 45), cv2.FONT_HERSHEY_PLAIN, 2, [25, 25, 255], 2)

    #make box area to be track and count 
    # this shoud be out of loop have to be calculate once and use the many times

    cv2.line(img, (int(img_size[0] * config.data_dict["cams"][cam_src]["x_top_line_from"]), \
        int(img_size[1] * config.data_dict["cams"][cam_src]["y_top_line_from"])), \
        (int(img_size[0] * config.data_dict["cams"][cam_src]["x_top_line_to"]), \
        int(img_size[1] * config.data_dict["cams"][cam_src]["y_top_line_to"])), \
        (0,244, 0), 2)
    cv2.line(img, (int(img_size[0] * config.data_dict["cams"][cam_src]["x_bottom_line_from"]), \
        int(img_size[1] * config.data_dict["cams"][cam_src]["y_bottom_line_from"])), \
        (int(img_size[0] * config.data_dict["cams"][cam_src]["x_bottom_line_to"]), \
        int(img_size[1] * config.data_dict["cams"][cam_src]["y_bottom_line_to"])), \
        (0,244, 0), 2)

    # cv2.line(img, (int(img_size[0] * .1), 0), (int(img_size[0] * .1), int(img_size[1])), (0,244, 0), 2)
    # cv2.line(img, (int(img_size[0] * .9), 0), (int(img_size[0] * .9), int(img_size[1])), (0,244, 0), 2)
      
    cv2.line(img, (int(img_size[0] * config.data_dict["cams"][cam_src]["x_left_line_from"]), \
        int(img_size[1] * config.data_dict["cams"][cam_src]["y_left_line_from"])), \
        (int(img_size[0] * config.data_dict["cams"][cam_src]["x_left_line_to"]), \
        int(img_size[1] * config.data_dict["cams"][cam_src]["y_left_line_to"])), \
        (0,244, 0), 2)
    cv2.line(img, (int(img_size[0] * config.data_dict["cams"][cam_src]["x_right_line_from"]), \
        int(img_size[1] * config.data_dict["cams"][cam_src]["y_right_line_from"])), \
        (int(img_size[0] * config.data_dict["cams"][cam_src]["x_right_line_to"]), \
        int(img_size[1] * config.data_dict["cams"][cam_src]["y_right_line_to"])), \
        (0,244, 0), 2)

    return img


def showImage(p,img):

    # cv2.imshow(p, img)
    # if cv2.waitKey(1) == ord('q'):  # q to quit
    #     raise StopIteration
    sender.send_image(image_window_name, img)
    time.sleep(1)




def processResult(outputs  ,c_name,img_shape, identities, cam_src):
    img_height = img_shape[1]
    img_width = img_shape[0]

    # itterate throu tracked items
    for output in outputs:
        
        center_x = int(((output[0])+(output[2]))/2)
        center_y = int(((output[1])+(output[3]))/2)
        # define box area to track on image
        if center_y <= int(img_height *.4) and center_y >= int(img_height * .15):
            pass

        #fiter by class name
        # the the fourth index of the output is track id which is unique        
        if c_name == 'Mask':
            config.mask_count.append(output[4])
        elif c_name == 'Without_mask':    
            config.no_mask_count.append(output[4])
        else:
            pass
    # use pythen {set} for count unique items in the each list
    config.total_mask_count = len(set(config.mask_count))
    config.total_no_mask_count = len(set(config.no_mask_count))
    print(f'\n\n mask={config.total_mask_count}  nomask={config.total_no_mask_count}\n\n')



    redis_save_count(cam_src, identities)


def clean_str(s):
    # Cleans a string by replacing special characters with underscore _
    return re.sub(pattern="[|@#!¡·$€%&()=?¿^*;:,¨´><+]", repl="_", string=s)


redis_con = redis.Redis(host='localhost', port = 6379)

def redis_save_count(i, id):


    cams = ['cam1',  'cam2']
    print (f' {cams[i]}  {type(cams[i])}    ++++++++++++++++++++++++            {type(i)}  {i}')
    redis_con.sadd(cams[i], str(id[0]))