#!/bin/bash

sudo service munge start

# Use the environment variables
CONTROLLER_HOST=${CONTROLLER_HOST:-}
CONTROLLER_PORT=${CONTROLLER_PORT:-}
HOSTNAME=${SYNPSE_DEVICE_NAME:-$(hostname)}

if [[ -n "$SLURM_NODENAME" ]]; then
    HOSTNAME=${SLURM_NODENAME}
fi

# Update /etc/hosts if CONTROLLER_HOST is set
# if [[ -n "$CONTROLLER_HOST" ]]; then
#     echo "${CONTROLLER_HOST} slurmmaster" | sudo tee -a /etc/hosts > /dev/null
# fi

# Start slurmd with or without --conf-server parameter based on CONTROLLER_HOST
if [[ -n "$CONTROLLER_HOST" && -n "$CONTROLLER_PORT" ]]; then
    # If CONTROLLER_HOST and CONTROLLER_PORT are set, use them as parameters
    exec sudo slurmd -Dvvv -N "$HOSTNAME" --conf-server "$CONTROLLER_HOST:$CONTROLLER_PORT"
else
    # If CONTROLLER_HOST is not set, start slurmd without --conf-server parameter
    exec sudo slurmd -Dvvv -N "$HOSTNAME"
fi