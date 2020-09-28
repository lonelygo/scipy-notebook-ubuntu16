# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
ARG BASE_CONTAINER=lonelygo/base-notebook-ubuntu-16
FROM $BASE_CONTAINER

LABEL maintainer="Jupyter Project <jupyter@googlegroups.com>"

USER root

# change source to tencent cloud
RUN apt-get update && apt-get -yq install apt-transport-https wget
RUN wget -O /etc/apt/sources.list http://mirrors.cloud.tencent.com/repo/ubuntu16_sources.list && apt-get clean
RUN mkdir /root/.pip && echo "[global]\nindex-url = https://mirrors.cloud.tencent.com/pypi/simple\ntrusted-host = mirrors.cloud.tencent.com" > /root/.pip/pip.conf

# Install all OS dependencies for fully functional notebook server
RUN apt-get update --fix-missing

RUN apt-get install -yq --no-install-recommends \
    build-essential \
    emacs-nox \
    vim-tiny \
    git \
    inkscape \
    jed \
    libsm6 \
    libxext-dev \
    libxrender1 \
    lmodern \
    netcat \
    python-dev \
    # ---- nbconvert dependencies ----
    texlive-xetex \
    texlive-fonts-recommended \
    # Bulide failed on error:Unable to locate package texlive-plain-generic
    # texlive-plain-generic \
    # ----
    tzdata \
    unzip \
    nano \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Switch back to jovyan to avoid accidental container runs as root
USER $NB_UID
