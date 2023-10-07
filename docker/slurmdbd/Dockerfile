FROM ubuntu:22.04


ARG DEBIAN_FRONTEND=noninteractive

SHELL [ "/bin/bash", "-c" ]

RUN apt-get update -qq --fix-missing && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        munge \
        mariadb-server \
        slurmd \
        slurmdbd \
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

# RUN apt update -y && apt install munge -y && apt install vim -y && apt install build-essential -y && apt install git -y && apt-get install mariadb-server -y && apt install wget -y

# ARG DEBIAN_FRONTEND=noninteractive
# RUN apt install slurmd slurmdbd slurm-client slurmctld -y
# RUN  useradd -m admin -s /usr/bin/bash -d /home/admin && echo "admin:admin" | chpasswd && adduser admin sudo && echo "admin     ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers 
RUN  echo "slurm:slurm" | chpasswd && adduser slurm sudo && echo "slurm     ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers 

# RUN apt update -y && apt install libopenmpi-dev -y && pip3 install mpi4py

# COPY slurm.conf /etc/slurm/
COPY docker/slurmdbd/cgroup.conf /etc/slurm/
# COPY slurmdbd.conf /etc/slurm/slurmdbd.conf
COPY docker/slurmdbd/docker-entrypoint.sh /etc/slurm/

COPY docker/munge.key /etc/munge/
RUN sudo chmod 400 /etc/munge/munge.key
RUN sudo chown munge:munge /etc/munge/munge.key

EXPOSE 6817 6818 6819 3306

WORKDIR /home/admin

ENTRYPOINT ["/etc/slurm/docker-entrypoint.sh"]