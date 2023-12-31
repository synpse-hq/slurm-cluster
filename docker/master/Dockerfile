FROM ubuntu:22.04

# RUN apt update -y && apt install munge -y && apt install vim -y && apt install build-essential -y && apt install git -y && apt-get install mariadb-server -y && apt install wget -y

ARG DEBIAN_FRONTEND=noninteractive

SHELL [ "/bin/bash", "-c" ]

RUN apt-get update -qq --fix-missing && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        munge \
        mariadb-server \
        slurmd \
        slurm-client \
        slurmctld \
        ca-certificates \
        curl \
        sudo \
        vim \
        wget \
      && \
    sudo apt-get -o Dpkg::Options::="--force-confmiss" install --reinstall -y netbase && \
    apt-get -y autoclean && \
    apt-get -y autoremove && \
    rm -rf /root/.cache && \
    rm -rf /var/lib/apt/lists/*

# Make Python3 available as `python`
# Also ensure that pip points to pip3
RUN ln -s /usr/bin/python3 /usr/bin/python

RUN useradd -m admin -s /usr/bin/bash -d /home/admin && echo "admin:admin" | chpasswd && adduser admin sudo && echo "admin     ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers 

# These will be overwritten
COPY docker/master/slurm.conf /etc/slurm-llnl/
COPY docker/master/cgroup.conf /etc/slurm-llnl/
COPY docker/master/docker-entrypoint.sh /etc/slurm-llnl/

# Authentication
COPY docker/munge.key /etc/munge/
RUN sudo chmod 400 /etc/munge/munge.key
RUN sudo chown munge:munge /etc/munge/munge.key

RUN chown -R admin:admin /etc/slurm-llnl

EXPOSE 6817 6818 6819 3306 

WORKDIR /home/admin

ENTRYPOINT ["/etc/slurm-llnl/docker-entrypoint.sh"]