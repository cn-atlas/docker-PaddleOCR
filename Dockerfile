FROM paddlepaddle/paddle:latest

RUN pip3 install paddlehub --upgrade -i https://mirrors.aliyun.com/pypi/simple

RUN mkdir -p /opt && cd /opt && git clone https://github.com/PaddlePaddle/PaddleOCR

RUN cd /opt/PaddleOCR && pip3 install -r requirments.txt -i https://mirrors.aliyun.com/pypi/simple

RUN mkdir -p /opt/PaddleOCR/inference

ADD https://paddleocr.bj.bcebos.com/20-09-22/server/rec/ch_ppocr_server_v1.1_rec_infer.tar /opt/PaddleOCR/inference
RUN tar xf /opt/PaddleOCR/inference/ch_ppocr_mobile_v1.1_rec_infer.tar -C /opt/PaddleOCR/inference

ADD https://paddleocr.bj.bcebos.com/20-09-22/server/det/ch_ppocr_server_v1.1_det_infer.tar /opt/PaddleOCR/inference
RUN tar xf /opt/PaddleOCR/inference/ch_ppocr_mobile_v1.1_det_infer.tar -C /opt/PaddleOCR/inference

ADD https://paddleocr.bj.bcebos.com/20-09-22/cls/ch_ppocr_mobile_v1.1_cls_infer.tar /home/PaddleOCR/inference
RUN tar xf /opt/PaddleOCR/inference/ch_ppocr_mobile_v1.1_cls_infer.tar -C /opt/PaddleOCR/inference

RUN cd /opt/PaddleOCR && export PYTHONPATH=/opt/PaddleOCR && hub install deploy/hubserving/ocr_system/

EXPOSE 8866

WORKDIR /opt/PaddleOCR

CMD ["/bin/bash","-c","export PYTHONPATH=/opt/PaddleOCR &&  hub serving start -m ocr_system --use_multiprocess"]
