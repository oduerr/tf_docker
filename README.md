# tf_docker

Docker container for tutorials on tensorflow. Based on https://github.com/tensorflow/tensorflow/tree/master/tensorflow/tools/docker

To run a single instance locally do:
```{bash}
docker run -p 8080:8080 -it oduerr/tf_docker
```
and open the browser pointing at [http://localhost:8080/](http://localhost:8080/). 

To run many instances with different ports on a server (e.g. on the Amazon Web Server). Start multiple containers mapping to port 8080.
```
docker run  -p 8081:8080 oduerr/tf_docker&
docker run  -p 8082:8080 oduerr/tf_docker&
```

Or better use loop
```
for i in `seq 8085 8090`; do docker run  -p $i:8080 oduerr/tf_docker&  done
```

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
