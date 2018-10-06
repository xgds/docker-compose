FROM nginx:latest
RUN  apt-get update
RUN  apt-get install -y \
     software-properties-common \
     gnupg
RUN  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
RUN  apt-add-repository "deb http://ppa.launchpad.net/ansible/ansible/ubuntu bionic main"
RUN  apt-get update
RUN  apt-get install -y \
     python     \
     ansible
COPY . /
RUN  ansible-playbook --connection=local /nginx.yml
RUN  apt-get remove --purge -y \
     software-properties-common \
     gnupg \
     python \
     ansible
