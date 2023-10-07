#!/bin/bash

# sudo sed -i "s/REPLACE_IT/CPUs=$(nproc)/g" /etc/slurm/slurm.conf

sudo chmod 600 /etc/slurm/slurmdbd.conf
sudo chown slurm:slurm /etc/slurm/slurmdbd.conf

sudo service munge start
# sudo service slurmctld start

slurmdbd -Dvvv
# tail -f /dev/null