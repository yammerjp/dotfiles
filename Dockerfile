FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    zsh \
    git \
    curl \
    gosu \
    vim \
#    sudo \
  && rm -rf /var/lib/apt/lists/*

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# RUN :
# RUN :
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
