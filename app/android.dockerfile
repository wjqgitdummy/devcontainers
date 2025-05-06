ARG BASE_IMAGE 
FROM ${BASE_IMAGE}

# set locale
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LANGUAGE=en_US:en

RUN sudo apt update && sudo apt install --no-install-recommends -y \
    locales \
    && sudo rm -rf /var/lib/apt/lists/*

RUN echo "en_US.UTF-8 UTF-8" | sudo tee /etc/locale.gen && \
    sudo locale-gen && \
    sudo update-locale LANG=en_US.UTF-8

# install jdk (default to v17)
RUN sudo apt update && sudo apt install --no-install-recommends -y \
    openjdk-8-jdk \
    openjdk-17-jdk \
    openjdk-21-jdk \
    && sudo rm -rf /var/lib/apt/lists/*

# install android sdk
## install deps
RUN sudo apt update && sudo apt install --no-install-recommends -y \
    wget \
    unzip \
    && sudo rm -rf /var/lib/apt/lists/*

## android envs
ENV ANDROID_HOME=${USERHOME}/android-sdk
ENV ANDROID_SDK_ROOT=${ANDROID_HOME} 
ENV ANDROID_CLI_ROOT="${ANDROID_HOME}/cmdline-tools/latest/bin"
ENV PATH="${PATH}:${ANDROID_CLI_ROOT}:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/platform-tools/bin:${ANDROID_HOME}/emulator"

## install cli tool
RUN SDK_TOOLS_URL="https://dl.google.com/android/repository/commandlinetools-linux-13114758_latest.zip" && \
	mkdir -p ${ANDROID_HOME}/cmdline-tools && \
	mkdir ${ANDROID_HOME}/platforms && \
	mkdir ${ANDROID_HOME}/ndk && \
	wget -O /tmp/cmdline-tools.zip -t 5 "${SDK_TOOLS_URL}" && \
	unzip -q /tmp/cmdline-tools.zip -d ${ANDROID_HOME}/cmdline-tools && \
	rm /tmp/cmdline-tools.zip && \
	mv ${ANDROID_HOME}/cmdline-tools/cmdline-tools ${ANDROID_HOME}/cmdline-tools/latest

## install sdk tools 
RUN yes | sdkmanager --licenses
RUN sdkmanager tools
RUN sdkmanager platform-tools

RUN mkdir -p ${USERHOME}/.android && \
    touch ${USERHOME}/.android/repositories.cfg

## NOTES: mount platforms and build-tools as volume 