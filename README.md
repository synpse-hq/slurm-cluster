# Synpse Slurm operator

## Deployment options

- `micro` - JupyterLab, master and compute nodes. Can run srun, sbatch, however no account and storage.
- `mini` - JupyterLab, master, compute nodes and storage. Can run srun, sbatch, squeue, sacct.
- `multi` - All + multi-node.


## Setting up mini slurm with accounting and storage

First, need to get the /etc/munge/munge.key shared between all containers. At the moment this is just mounted form the host.


Debugging:

1. Had to add the key to the host and change perms/owner

```
sudo adduser munge
sudo chmod 400 /etc/munge/munge.key
sudo chown munge:munge /etc/munge/munge.key
```


2. Somehow slurm master was stopped? Had to SSH, exec into the slurmmaster container and start the service within it.

```
root@slurmmaster:~# service slurmctld start
 * Starting slurm central management daemon slurmctld  
```

## Slurm

A Slurm scheduler cluster typically consists of the following components:

- Slurm controller: The Slurm controller is the central component of the cluster and is responsible for managing the scheduling and execution of jobs. It communicates with the compute nodes to allocate resources and manage job execution.

- Compute nodes: The compute nodes are the machines in the cluster that are used to run jobs. They are typically connected to the Slurm controller via a high-speed network.

- Slurm database: The Slurm database is used to store information about the jobs and resources in the cluster. It is typically a relational database such as MySQL or PostgreSQL.

- Slurm accounting storage: The Slurm accounting storage is used to store information about job accounting and usage statistics. It is typically a time-series database such as Graphite or InfluxDB.

- Slurm plugins: Slurm plugins are used to extend the functionality of the Slurm scheduler. They can be used to implement custom scheduling policies, resource allocation algorithms, and other features.

Each of these components plays a critical role in the operation of a Slurm scheduler cluster. The Slurm controller is responsible for managing the scheduling and execution of jobs, while the compute nodes are responsible for running the jobs themselves. The Slurm database and accounting storage are used to store information about the jobs and resources in the cluster, while the plugins are used to extend the functionality of the scheduler.

