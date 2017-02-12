# Dockerfile

# Using debian:jessie for it's smaller size over ubuntu
FROM debian:jessie

ENV REFRESHED_AT 2017-02-12

USER root

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Run updates and install deps
RUN apt-get update

RUN apt-get install -y -q --no-install-recommends \
    apt-transport-https \
    build-essential \
    ca-certificates \
    curl \
    g++ \
    gcc \
    git \
    git-core \
    ssh \
    make \
    nginx \
    sudo \
    wget \
    vim \
    graphicsmagick \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get -y autoclean

ENV WORKER_HOME /home/worker

# Setup User
RUN useradd --home $WORKER_HOME -M worker -K UID_MIN=10000 -K GID_MIN=10000 -s /bin/bash
RUN mkdir $WORKER_HOME
RUN chown worker:worker $WORKER_HOME
RUN adduser worker sudo
RUN echo 'worker ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers