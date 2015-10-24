#docker
FROM ubuntu:14.04

MAINTAINER 0303 <farmatholin@gmail.com>

RUN apt-get update && \
    apt-get install -y python-software-properties software-properties-common
RUN add-apt-repository -y ppa:gluster/glusterfs-3.5 && \
    apt-get update && \
    apt-get install -y glusterfs-server supervisor

RUN mkdir -p /var/log/supervisor

ENV GLUSTER_VOL ims
ENV GLUSTER_REPLICA 3
ENV GLUSTER_BRICK_PATH /gluster_volume
ENV GLUSTER_PEER **ChangeMe**
ENV DEBUG 0

VOLUME ["/gluster_volume"]

RUN mkdir -p /usr/local/bin
ADD ./scripts /usr/local/bin
RUN chmod +x /usr/local/bin/*.sh
ADD ./scripts/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/local/bin/docker_run.sh"]