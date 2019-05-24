FROM ubuntu:xenial

RUN apt-get update
RUN apt-get install -y software-properties-common
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
RUN apt-add-repository "deb http://ppa.launchpad.net/ansible/ansible/ubuntu xenial main"
RUN apt-get update
RUN apt-get install -y ansible 

COPY ./ansible/apt /ansible/apt
RUN cd /ansible/apt && ansible-playbook --connection=local install_apt.yml

COPY ./ansible/pip /ansible/pip
RUN cd /ansible/pip && ansible-playbook --connection=local install_pip.yml

COPY ./ansible/pip3 /ansible/pip3
RUN cd /ansible/pip3 && ansible-playbook --connection=local install_pip3.yml

COPY ./ansible/npm /ansible/npm
RUN cd /ansible/npm && ansible-playbook --connection=local install_npm.yml

WORKDIR /root
RUN git clone https://github.com/xgds/xgds_subsea
RUN cd  xgds_subsea && \
    git submodule init &&   \
    git submodule foreach git checkout master

RUN cd /etc/init.d && ln -s /root/xgds_subsea/pyraptord .

RUN cd /root/xgds_subsea && \
    python ./management/bootstrap.py --yes genSourceme genSettings

ARG BING_MAPS_API_KEY
ENV BING_MAPS_API_KEY "$BING_MAPS_API_KEY"

WORKDIR /ansible
COPY ./ansible /ansible
RUN ansible-playbook --connection=local apache.yml
RUN ansible-playbook --connection=local xgds.yml

RUN chmod -R 755 /root

RUN mkdir -p /usr/lib/python2.7/dist-packages/gi/overrides
RUN curl -s https://raw.githubusercontent.com/jcupitt/libvips/8.4/python/packages/gi/overrides/Vips.py > /usr/lib/python2.7/dist-packages/gi/overrides/Vips.py

RUN mkdir /home/xgds && \
    ln -s /root/xgds_subsea /home/xgds/xgds_subsea

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /
COPY startup.sh startup.sh
COPY resume.sh resume.sh
COPY setup-new.sh setup-new.sh
CMD sh /startup.sh
