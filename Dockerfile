FROM tensorflow/tensorflow:1.2.1-gpu-py3
#FROM tensorflow/tensorflow:1.0.0-gpu-py3
# Removing some notebook which caused confusion
RUN rm /notebooks/1_hello_tensorflow.ipynb
RUN rm /notebooks/2_getting_started.ipynb
RUN rm /notebooks/3_mnist_from_scratch.ipynb

MAINTAINER oliver duerr <dueo@zhaw.ch>

RUN pip --no-cache-dir install \
        ipykernel \
        jupyter \
        matplotlib \
        pandas \
        h5py \
#        keras \
        tflearn \
        ggplot

# RUN pip --no-cache-dir install tflearn
# RUN pip install git+https://github.com/tflearn/tflearn.git
# RUN pip install keras

RUN apt-get update && apt-get install -y git

# Clean
RUN apt-get clean && \
rm -rf /var/lib/apt/lists/*

# Default directory that will be saved by htcondor
#RUN mkdir /tmp/results
#RUN nvidia-smi -f /tmp/temp.txt

# COPY -> to copy files/data from to localmachine
COPY notebooks /notebooks

# TensorBoard
EXPOSE 6006
# IPython
EXPOSE 8888

WORKDIR "/notebooks"
COPY notebooks /notebooks


COPY run_jupyter_2.sh /
CMD ["/run_jupyter_2.sh"]
