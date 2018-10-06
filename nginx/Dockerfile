FROM phusion/baseimage
RUN  apt-get update
RUN  apt-get install -y software-properties-common
RUN  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
RUN  apt-add-repository "deb http://ppa.launchpad.net/ansible/ansible/ubuntu bionic main"
RUN  apt-get update
RUN  apt-get install -y \
     python     \
     nginx      \
     ansible
COPY . /
RUN  ansible-playbook --connection=local /nginx.yml
RUN  chmod -R 755 /root
RUN  mkdir /etc/service/nginx
RUN  cp /run-nginx.sh /etc/service/nginx/run
RUN  apt-get clean && \
     rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
CMD  /sbin/my_init

