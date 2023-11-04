#!/bin/bash

# sudo sed -i "s/REPLACE_IT/CPUs=$(nproc)/g" /etc/slurm/slurm.conf

sudo service munge start

# Use the environment variables
CONTROLLER_HOST=${CONTROLLER_HOST}
CONTROLLER_PORT=${CONTROLLER_PORT}

# Using synpse device name
HOSTNAME=${SYNPSE_DEVICE_NAME}

sudo echo "${CONTROLLER_HOST} slurmmaster" >> /etc/hosts

# Start slurmd in debug/foreground mode
exec sudo slurmd -Dvvv -N ${HOSTNAME} --conf-server ${CONTROLLER_HOST} ${CONTROLLER_PORT}
