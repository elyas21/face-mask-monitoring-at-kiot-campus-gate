# Face mask monitoring system for kiot campus

This project is based on https://github.com/mikel-brostrom/Yolov5_DeepSort_Pytorch 

Title: Face Mask Monitoring at KIOT Campus Gate

A project Submitted to Department of Software Engineering for Partial Fulfillment of the Requirement for the Degree of Bachelor in Software in Engineering.



## Requirements

Python 3.8 or later with all requirements.txt dependencies installed, including torch>=1.7. To install run:

`pip install -U -r requirements.txt`

All dependencies are included in the associated docker images. Docker requirements are: 
- `nvidia-docker`
- Nvidia Driver Version >= 440.44

## Before you run the tracker

1. Clone the repository recursively:

`git clone --recurse-submodules https://github.com/mikel-brostrom/Yolov5_DeepSort_Pytorch.git`

If you already cloned and forgot to use `--recurse-submodules` you can run `git submodule update --init`

2. Github block pushes of files larger than 100 MB (https://help.github.com/en/github/managing-large-files/conditions-for-large-files). Hence you need to download two different weights: the ones for yolo and the ones for deep sort

- download the yolov5 weight from the latest realease https://github.com/ultralytics/yolov5/releases. Place the downlaoded `.pt` file under `yolov5/weights/`
- download the deep sort weights from https://drive.google.com/drive/folders/1xhG0kRH1EX5B9_Iz8gQJb7UNnn_riXi6. Place ckpt.t7 file under`deep_sort/deep/checkpoint/`

## Tracking

Tracking can be run on most video formats

```bash
python3 track.py --source ...
```

- Video:  `--source video.mp4`
- Webcam:  `--source 0`
- RTSP stream:  `--source rtsp://0.0.0.0/**
- HTTP stream:  `--source http://**`

MOT compliant results can be saved to `inference/output` by 

```bash
python3 track.py --source ... --save-txt
```

## Other information

For more detailed information about the algorithms and their corresponding lisences used in this project access their official github implementations.

## How to strart
1 run recognition: `python3 e-track.py --source config/cam.txt --img-size 32  --weights /home/black/Downloads/best.pt`
2 run streaming servers: `python try/socket/catchserver.py ` and `python try/socket/catchserver2.py`
2 run server: `python run_server`

## Deployment Diagram 
![DD Diagram](https://firebasestorage.googleapis.com/v0/b/whosela.appspot.com/o/fmddd.PNG?alt=media&token=8e2c59eb-0440-43af-96f3-3c1848c81f0e)


Prepared By
Elyas Abate 


Advisor: Ashenafi Workie (MSc.)
Submitted Date: July
