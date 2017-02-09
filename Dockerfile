FROM tensorflow/tensorflow:0.12.1

MAINTAINER oliver duerr <dueo@zhaw.ch>

RUN apt-get update && apt-get install -y \
                python-numpy \
                python-dev \
                cmake \
                zlib1g-dev \
                libjpeg-dev \
                xvfb \
                libav-tools \
                xorg-dev \
                python-opengl \
                libboost-all-dev \
                libsdl2-dev \
                swig \
                git

RUN pip --no-cache-dir install ipykernel jupyter matplotlib pandas h5py

#RUN pip --no-cache-dir install tflearn

RUN pip install git+https://github.com/tflearn/tflearn.git

RUN pip install keras

# Clean
RUN apt-get clean && \
rm -rf /var/lib/apt/lists/*

# Default directory that will be saved by htcondor
#RUN mkdir /tmp/results
#RUN nvidia-smi -f /tmp/temp.txt

# COPY -> to copy files/data from to localmachine

# TensorBoard
EXPOSE 6006
# IPython
EXPOSE 8888

WORKDIR "/notebooks"

# Test GPS
#CMD echo "Starting GPS"
#CMD ["python python/gps/gps_main.py"]

# Start Jupyter Notebook for interactive mode
CMD ["jupyter nbextension enable --py --sys-prefix widgetsnbextension"]
CMD ["jupyter notebook "$@" --NotebookApp.token='\"tensochiefs_rulez\"'"]


#CMD ["/run_jupyter_2.sh"]
