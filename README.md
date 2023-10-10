<div align="center">

  <img src="https://github.com/synpse-hq/slurm-cluster/blob/main/slurm.svg" width="200px">
  <br>

  **Automated Slurm setup for development, testing and training.**

  ---

  <p align="center">
    <a href="https://slurm.schedmd.com/documentation.html">Slurm docs</a> •   
    <a href="https://docs.synpse.net">Docs</a> •  
    <a href="https://discord.gg/dkgN4vVNdm">Discord</a> •
    <a href="https://cloud.synpse.net/">Synpse Platform</a>
  </p>

</div>


## Deployment options

This repository contains instructions and tooling to get you a Slurm environment where you can experiment with working `sbatch`, `srun`, `sinfo` and `sacct` commands. 

- `mini` - JupyterLab, master, compute nodes and storage. Can run srun, sbatch, squeue, sacct.
- `multi` - (*coming soon*) All + multi-node.
- `auto` - (*coming soon*) automated Slurm operator that can automatically add more nodes into the cluster, manages configuration, shared storage and DNS.

## Prerequisites

-  Linux VM, can be your own PC, university server or a cloud machine from your favorite provider such as Google Cloud Platform, AWS, Azure, Hetzner, etc.
-  [Synpse account](https://cloud.synpse.net/) - free

While the installation is straightforward, I will try to keep it verbose and simple. Our three main steps are:

1. Setting up Synpse agent on your machine (it will deploy and run Slurm)
2. Start Slurm
3. Use the synpse CLI to securely connect to Jupyter head node so we can run Slurm jobs

## Install synpse agent

### Option 1: Cloud virtual machine

For cloud, first go to the "Provisioning" page:

![](https://github.com/synpse-hq/slurm-cluster/blob/main/static/provisioning.png)

And then click on the "Provision cloud VM":

![](https://github.com/synpse-hq/slurm-cluster/blob/main/static/provision.png)

Insert this into the clout-init steps. Otherwise, if you already have the machine then use the steps from the "Option 2".

### Option 2: On-prem machine

With on-prem machines you can just go to the "Provisioning", then click on the "Provision device" and copy the command.

Now, SSH into your machine and run the command.


### Label device

Once the device is online:

![](https://github.com/synpse-hq/slurm-cluster/blob/main/static/online.png)

Go to the labels section and add a label: "type": "server". Synpse starts applications based on labels and this is what we have in our template.

![](https://github.com/synpse-hq/slurm-cluster/blob/main/static/label.png)


## Starting Slurm



## Troubleshooting

2. Trying to use Mariadb root password for the database in the slurmddb. Might help?

2. Somehow slurm master was stopped? Had to SSH, exec into the slurmmaster container and start the service within it.

```
root@slurmmaster:~# service slurmctld start
 * Starting slurm central management daemon slurmctld  
```

4. No cluster issues in the database. Port is set but getting:

```
port is set but still seeing error: "slurmdbd: error: _add_registered_cluster: trying to register a cluster (cluster) with no remote port" in the slurmdbd logs
```

Attempted:

```
root@slurmjupyter:/home/admin# sacctmgr show cluster
   Cluster     ControlHost  ControlPort   RPC     Share GrpJobs       GrpTRES GrpSubmit MaxJobs       MaxTRES MaxSubmit     MaxWall                  QOS   Def QOS 
---------- --------------- ------------ ----- --------- ------- ------------- --------- ------- ------------- --------- ----------- -------------------- --------- 
root@slurmjupyter:/home/admin# sacctmgr create cluster cluster
 Adding Cluster(s)
  Name           = cluster
Would you like to commit changes? (You have 30 seconds to decide)
(N/y): y

root@slurmjupyter:/home/admin# 
root@slurmjupyter:/home/admin# sacctmgr show cluster
   Cluster     ControlHost  ControlPort   RPC     Share GrpJobs       GrpTRES GrpSubmit MaxJobs       MaxTRES MaxSubmit     MaxWall                  QOS   Def QOS 
---------- --------------- ------------ ----- --------- ------- ------------- --------- ------- ------------- --------- ----------- -------------------- --------- 
   cluster                            0     0         1                                                                                           normal  
```

After this we have got the cluster tables in

## Slurm

A Slurm scheduler cluster typically consists of the following components:

- Slurm controller: The Slurm controller is the central component of the cluster and is responsible for managing the scheduling and execution of jobs. It communicates with the compute nodes to allocate resources and manage job execution.

- Compute nodes: The compute nodes are the machines in the cluster that are used to run jobs. They are typically connected to the Slurm controller via a high-speed network.

- Slurm database: The Slurm database is used to store information about the jobs and resources in the cluster. It is typically a relational database such as MySQL or PostgreSQL.

- Slurm accounting storage: The Slurm accounting storage is used to store information about job accounting and usage statistics. It is typically a time-series database such as Graphite or InfluxDB.

- Slurm plugins: Slurm plugins are used to extend the functionality of the Slurm scheduler. They can be used to implement custom scheduling policies, resource allocation algorithms, and other features.

Each of these components plays a critical role in the operation of a Slurm scheduler cluster. The Slurm controller is responsible for managing the scheduling and execution of jobs, while the compute nodes are responsible for running the jobs themselves. The Slurm database and accounting storage are used to store information about the jobs and resources in the cluster, while the plugins are used to extend the functionality of the scheduler.

## TODO:

- slurm.conf needs CPUs for each node