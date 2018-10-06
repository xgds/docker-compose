FROM phusion/baseimage

RUN  apt-get update
RUN  apt-get install -y software-properties-common
RUN  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
RUN  apt-add-repository "deb http://ppa.launchpad.net/ansible/ansible/ubuntu bionic main"
RUN  apt-get update
RUN  apt-get install -y \
     git        \
     sudo       \
     python     \
     python-pip \
     apache2    \
     libapache2-mod-wsgi \
     mariadb-server      \
     mariadb-client      \
     python-mysqldb      \
     libmariadb-client-lgpl-dev \
     ansible     \
     python-gdal \
     memcached   \
     libmemcached-tools \
     libmemcached-dev \
     zlib1g-dev  \
     libvips-dev \
     python-gi   \
     gir1.2-vips-8.0 \
     libgif-dev

WORKDIR /root
RUN  git clone https://github.com/xgds/xgds_subsea
RUN  cd  xgds_subsea && \
     git submodule init &&   \
     git submodule sync &&   \
     git submodule foreach git checkout master && \
     git submodule update
RUN  pip install --upgrade pip

COPY ./requirements.txt /requirements.txt
RUN  pip install -r /requirements.txt
RUN  cd /root/xgds_subsea && \
     python ./management/bootstrap.py --yes genSourceme genSettings

RUN  curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN  apt-get install -y nodejs
RUN  npm -g  install yuglify

COPY . /

WORKDIR /ansible-yml
RUN     ansible-playbook --connection=local apache.yml
RUN     ansible-playbook --connection=local mysql.yml
RUN     ansible-playbook --connection=local xgds.yml

RUN  chmod -R 755 /root

RUN  rm -f /etc/service/sshd/down
RUN  /etc/my_init.d/00_regen_ssh_host_keys.sh > /dev/null 2>&1
RUN  mkdir -p /root/.ssh

RUN  mkdir /etc/service/mysql
ADD  run-scripts/run-mysql.sh /etc/service/mysql/run
RUN  mkdir /etc/service/apache
ADD  run-scripts/run-apache.sh /etc/service/apache/run

WORKDIR /
RUN  /sbin/my_init & \
     sleep 1 && \
     cd /root/xgds_subsea && \
     ./manage.py prep && \
     ./manage.py prepnpm && \
     ./manage.py prepmigrations && \
     ./manage.py migrate

RUN  apt-get clean && \
     rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
CMD  /sbin/my_init
