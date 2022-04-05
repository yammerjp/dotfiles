FROM ubuntu:latest

RUN apt-get update \
  && apt-get -y upgrade \
  && apt-get -y install curl \
  && apt-get -y install zsh \
  && apt-get -y install git \
  && apt-get -y install sudo \
  && apt-get -y install vim \
  && apt-get -y clean \
  && rm -rf /var/lib/apt/lists/*

ARG UID=1000
ARG USER=ubuntu
ARG PASSWORD=password
　RUN useradd -m --uid ${UID} --groups sudo ${USER} \
  && echo ${USER}:${PASSWORD} | chpasswd

COPY ./clone.sh /home/ubuntu/clone.sh
RUN mkdir /home/ubuntu/dotfiles-remote

USER ${USER}
WORKDIR /home/${USER}
