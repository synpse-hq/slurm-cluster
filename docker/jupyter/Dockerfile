FROM ubuntu:22.04

# RUN apt update -y && apt install munge -y && apt install vim -y && apt install build-essential -y && apt install git -y && apt-get install mariadb-server -y && apt install wget -y
RUN apt update -y && apt install munge vim build-essential git wget -y

ARG DEBIAN_FRONTEND=noninteractive

SHELL [ "/bin/bash", "-c" ]


# Install common dependencies with DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq --fix-missing && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        apt-clone \
        build-essential \
        bzip2 \
        ca-certificates \
        cmake \
        curl \
        git \
        graphviz \
        pkg-config \        
        sudo \
        unzip \
        vim \
        wget \
        pip \
        slurm-client \
      && \
    sudo apt-get -o Dpkg::Options::="--force-confmiss" install --reinstall -y netbase && \
    apt-get -y autoclean && \
    apt-get -y autoremove && \
    rm -rf /root/.cache && \
    rm -rf /var/lib/apt/lists/*


# RUN apt install slurm-client curl -y

# RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN useradd -m admin -s /usr/bin/bash -d /home/admin && echo "admin:admin" | chpasswd && adduser admin sudo && echo "admin     ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN pip install jupyterlab

COPY slurm.conf /etc/slurm-llnl/
COPY cgroup.conf /etc/slurm-llnl/
COPY docker-entrypoint.sh /etc/slurm-llnl/

WORKDIR /home/admin

EXPOSE 8888

ENV USER admin
ENV SHELL bash

# RUN apt install libopenmpi-dev -y && pip install mpi4py && pip install jupyterlab_slurm
RUN pip install jupyterlab_slurm

ENTRYPOINT ["/etc/slurm-llnl/docker-entrypoint.sh"]