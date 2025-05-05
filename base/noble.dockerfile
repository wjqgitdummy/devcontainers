ARG ubuntu_release=noble
FROM ubuntu:${ubuntu_release}

ARG ubuntu_release

# install sudo
RUN apt update && apt install --no-install-recommends -y \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# disable password
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER ubuntu

# set default shell
ENV SHELL=/bin/bash

CMD [ "bash" ]