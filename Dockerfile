FROM tensorflow/tensorflow:1.0.0-py3

MAINTAINER oliver duerr <dueo@zhaw.ch>

RUN pip --no-cache-dir install ipykernel jupyter matplotlib pandas h5py

#RUN pip --no-cache-dir install tflearn

#RUN pip install git+https://github.com/tflearn/tflearn.git

RUN pip install keras

RUN pip install cpickle

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
#CMD ["jupyter nbextension enable --py --sys-prefix widgetsnbextension"]
#CMD ["jupyter notebook "$@" --NotebookApp.token='\"tensochiefs_rulez\"'"]

COPY run_jupyter_2.sh /
CMD ["/run_jupyter_2.sh"]
