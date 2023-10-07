#!/bin/bash


sudo chmod 600 /etc/slurm/slurmdbd.conf
sudo chown slurm:slurm /etc/slurm/slurmdbd.conf

sudo service munge start

slurmdbd -Dvvv