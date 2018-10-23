FROM ubuntu:xenial
RUN  apt-get update
RUN  apt-get install -y software-properties-common
RUN  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
RUN  apt-add-repository "deb http://ppa.launchpad.net/ansible/ansible/ubuntu bionic main"
RUN  apt-get update
RUN  apt-get install -y \
     mariadb-server \
     ansible    \
     mariadb-client \
     python-mysqldb
COPY ./mysql.yml /mysql.yml
COPY ./variables.yml /variables.yml
RUN  ansible-playbook --connection=local /mysql.yml
RUN  apt-get clean && \
     rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
CMD  exec /usr/bin/mysqld_safe
