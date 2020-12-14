FROM ubuntu
MAINTAINER mani.v.1985@gmail.com
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install supervisor apache2 openssh-server -y
RUN mkdir /var/lock/apache2 /var/run/apache2 /var/run/sshd
RUN sed -i '/\[supervisor\]/a nodeamon=true' /etc/supervisor/supervisord.conf
RUN echo 'root:admin123' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
COPY myservice.conf /etc/supervisor/conf.d/
EXPOSE 80 22
CMD ["supervisord"]


