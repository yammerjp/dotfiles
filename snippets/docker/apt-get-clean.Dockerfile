FROM debian
RUN apt-get -qqy update && apt-get -qqy install \
  git \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
