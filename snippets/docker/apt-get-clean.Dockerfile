FROM debian
RUN apt update && apt install -y \
  git \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
