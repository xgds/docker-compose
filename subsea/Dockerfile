FROM ubuntu:xenial

RUN apt-get update
RUN apt-get install -y software-properties-common
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
RUN apt-add-repository "deb http://ppa.launchpad.net/ansible/ansible/ubuntu bionic main"
RUN apt-get update
RUN apt-get install -y ansible 

COPY ./ansible-yml/apt /ansible-yml/apt
RUN cd /ansible-yml/apt && ansible-playbook --connection=local install_apt.yml

COPY ./ansible-yml/pip /ansible-yml/pip
RUN cd /ansible-yml/pip && ansible-playbook --connection=local install_pip.yml

COPY ./ansible-yml/npm /ansible-yml/npm
RUN cd /ansible-yml/npm && ansible-playbook --connection=local install_npm.yml

WORKDIR /root
RUN git clone https://github.com/xgds/xgds_subsea
RUN cd  xgds_subsea && \
    git submodule init &&   \
    git submodule update

RUN cd /root/xgds_subsea && \
    python ./management/bootstrap.py --yes genSourceme genSettings

ARG BING_MAPS_API_KEY
ENV BING_MAPS_API_KEY "$BING_MAPS_API_KEY"

COPY . /
WORKDIR /ansible-yml
RUN ansible-playbook --connection=local apache.yml
RUN ansible-playbook --connection=local xgds.yml

RUN chmod -R 755 /root

RUN mkdir /home/xgds && \
    ln -s /root/xgds_subsea /home/xgds/xgds_subsea

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD sh /startup.sh
