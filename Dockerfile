FROM python:3.7-buster

#RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

RUN pip3.7 install opencv-python==4.2.0.32 paddlehub paddlepaddle --upgrade -i https://mirrors.aliyun.com/pypi/simple

RUN mkdir -p /opt && cd /opt && git clone https://gitee.com/paddlepaddle/PaddleOCR 

RUN cd /opt/PaddleOCR && pip3.7 install -r requirements.txt -i https://mirrors.aliyun.com/pypi/simple

#RUN mkdir -p /opt/PaddleOCR/inference

#ADD https://paddleocr.bj.bcebos.com/20-09-22/mobile/rec/ch_ppocr_mobile_v1.1_rec_infer.tar /opt/PaddleOCR/inference
#RUN tar xf /opt/PaddleOCR/inference/ch_ppocr_mobile_v1.1_rec_infer.tar -C /opt/PaddleOCR/inference

#ADD https://paddleocr.bj.bcebos.com/20-09-22/mobile/det/ch_ppocr_server_v1.1_det_infer.tar /opt/PaddleOCR/inference
#RUN tar xf /opt/PaddleOCR/inference/ch_ppocr_mobile_v1.1_det_infer.tar -C /opt/PaddleOCR/inference

#ADD https://paddleocr.bj.bcebos.com/20-09-22/cls/ch_ppocr_mobile_v1.1_cls_infer.tar /opt/PaddleOCR/inference
#RUN tar xf /opt/PaddleOCR/inference/ch_ppocr_mobile_v1.1_cls_infer.tar -C /opt/PaddleOCR/inference

#RUN cd /opt/PaddleOCR && sed -i 's/mobile_v1.1_det/server_v1.1_det/g' deploy/hubserving/ocr_system/params.py && sed -i 's/mobile_v1.1_rec/server_v1.1_rec/g' deploy/hubserving/ocr_system/params.py && sed -i 's/mobile_v1.1_rec/server_v1.1_rec/g' deploy/hubserving/ocr_rec/params.py

#RUN cd /opt/PaddleOCR && export PYTHONPATH=/opt/PaddleOCR && hub install deploy/hubserving/ocr_rec/ 

EXPOSE 8866

WORKDIR /opt/PaddleOCR

CMD ["/bin/bash","-c","export PYTHONPATH=/opt/PaddleOCR && hub serving start -m chinese_ocr_db_crnn_mobile -p 8866 --use_multiprocess"]

