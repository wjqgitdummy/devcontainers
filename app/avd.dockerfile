ARG BASE_IMAGE 
FROM ${BASE_IMAGE}

# kvm and qemu for emulator HA
## install qemu-kvm in both host and container
RUN sudo apt update && sudo apt install --no-install-recommends -y \
    qemu-kvm \
    && sudo rm -rf /var/lib/apt/lists/*

## add user to host Kvm group
RUN sudo groupadd -g 133 -o -r kvm133 && \
    sudo usermod -a -G kvm133 ${USER}

# install emulator
RUN sdkmanager emulator

# add NVIDIA capabilities (in dockerfile)
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics