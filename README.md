# tf_docker

## Docker container for tutorials on tensorflow. 
Based on https://github.com/tensorflow/tensorflow/tree/master/tensorflow/tools/docker

### To run a single instance locally do:
```{bash}
docker run -p 8080:8888 -p 8081:6006 -it oduerr/tf_docker
```
and open the browser pointing at [http://localhost:8080/](http://localhost:8080/). 

### Torun many instances 
with different ports on a server (e.g. on the Amazon Web Server). Start multiple containers mapping to port 8080.
```
docker run  -p 8081:8888 oduerr/tf_docker&
docker run  -p 8082:8888 oduerr/tf_docker&
```

Or better use a loop
```
for i in `seq 8800 8850`; do docker run -d -p $i:8888 oduerr/tf_docker;  done;
```

### Notes using AWS
I used the provided Amazon AMI (Amazon Linux AMI 2016.03.3 (HVM), SSD Volume Type - ami-31490d51). However it does not come with docker installed. I installed it as descripbed in 
http://docs.aws.amazon.com/AmazonECS/latest/developerguide/docker-basics.html#install_docker

### tmpnb
Alternative integrate the images in [https://github.com/jupyter/tmpnb](https://github.com/jupyter/tmpnb).
Code not working prop yet
```
docker pull jupyter/minimal-notebook
export TOKEN=$( head -c 30 /dev/urandom | xxd -p )
docker run --net=host -d -e CONFIGPROXY_AUTH_TOKEN=$TOKEN --name=proxy jupyter/configurable-http-proxy --default-target http://127.0.0.1:8080
docker run --net=host -d -e CONFIGPROXY_AUTH_TOKEN=$TOKEN \
           -v /var/run/docker.sock:/docker.sock \
           jupyter/tmpnb python orchestrate.py --image='oduerr/tf_docker'
```


