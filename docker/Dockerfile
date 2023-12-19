# Based on a light-weight python container
#FROM python:3-slim-bullseye
FROM rockylinux:9

RUN yum install -y libX11 nss atk-devel at-spi2-atk cups-libs libdrm libXcomposite libXdamage libXrandr libxkbcommon libgbm alsa-lib libxshmfence fontconfig && yum clean all
RUN yum install -y gtk2 gtk3 xorg-x11-server-Xvfb xterm dejavu-sans-fonts dejavu-sans-mono-fonts dejavu-serif-fonts \
    zip wget webkitgtk4 libXScrnSaver && yum clean all

# Unpack Sigasi Veresta in the current directory before building the container
COPY sigasi-veresta /opt/sigasi-veresta

COPY design /root/design

# Configure the correct license for your setup
ENV PATH="/opt/sigasi-veresta:${PATH}" \
    SIGASI_LM_LICENSE_FILE=27040@elvis
