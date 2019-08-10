FROM ubuntu:18.04

# Install dependencies
RUN apt update && apt upgrade -y && apt install -y \
    ruby=1:2.5.1 \
    redis \
    unzip \
    wget \
    bundler \
    vim \
    zlib1g-dev \
    curl

# Add the startup script and trebekbot files to the /root folder
ADD start_server.sh /root
ADD trebekbot /root/trebekbot

# Install Ruby dependencies
RUN cd /root/trebekbot && bundle install

EXPOSE 80

ENTRYPOINT [ "/root/start_server.sh" ]
