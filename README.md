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

- [What is Slurm?](#what-is-slurm)
- [Deployment options](#deployment-options)
- [Prerequisites](#prerequisites)
- [Install synpse agent](#install-synpse-agent)
  - [Option 1: Cloud virtual machine](#option-1-cloud-virtual-machine)
  - [Option 2: On-prem machine](#option-2-on-prem-machine)
  - [Set a name and add label to the device](#set-a-name-and-add-label-to-the-device)
- [Starting Slurm](#starting-slurm)
  - [Add config files](#add-config-files)
  - [Start Slurm](#start-slurm)
- [Connecting to Slurm](#connecting-to-slurm)
  - [Install and configure CLI](#install-and-configure-cli)
  - [Connect to Slurm Jupyter node](#connect-to-slurm-jupyter-node)
- [Running a Slurm job](#running-a-slurm-job)
- [Hacking](#hacking)
  - [Adding more packages into the workers](#adding-more-packages-into-the-workers)
- [Troubleshooting](#troubleshooting)
    - [Somehow slurm master was stopped? Had to SSH, exec into the slurmmaster container and start the service within it](#somehow-slurm-master-was-stopped-had-to-ssh-exec-into-the-slurmmaster-container-and-start-the-service-within-it)
    - [No cluster issues in the database](#no-cluster-issues-in-the-database)


## What is Slurm?

Slurm is an open source, fault-tolerant, and highly scalable cluster management and job scheduling system for large and small Linux clusters. Slurm requires no kernel modifications for its operation and is relatively self-contained. As a cluster workload manager, Slurm has three key functions. First, it allocates exclusive and/or non-exclusive access to resources (compute nodes) to users for some duration of time so they can perform work. Second, it provides a framework for starting, executing, and monitoring work (normally a parallel job) on the set of allocated nodes. Finally, it arbitrates contention for resources by managing a queue of pending work.

Slurm architecture:

![](https://github.com/synpse-hq/slurm-cluster/blob/main/static/slurm.png)

So, it's not that easy to get it up and running, hence this guide!

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


### Set a name and add label to the device

Once the device is online:

![](https://github.com/synpse-hq/slurm-cluster/blob/main/static/online.png)

Go to the labels section and add a label: "type": "server". Synpse starts applications based on labels and this is what we have in our template.

![](https://github.com/synpse-hq/slurm-cluster/blob/main/static/label.png)


Then, change the device name to `mini-slurm`, this will be helpful later.

## Starting Slurm

### Add config files

Click on the "default" namespace on the left and then go to the "secrets":

![](https://github.com/synpse-hq/slurm-cluster/blob/main/static/secrets.png)

Here, create two secrets:

- `slurmConf` with contents from https://github.com/synpse-hq/slurm-cluster/blob/main/mini/slurm.conf
- `slurmdbdConf` with contents from https://github.com/synpse-hq/slurm-cluster/blob/main/mini/slurmdbd.conf

You can change the configuration here, it will be available to all Slurm components. You can find more info about slurm.conf here https://slurm.schedmd.com/slurm.conf.html.

### Start Slurm

Once you have the configuration secrets added, click on the "default" namespace again and then click "new application". Delete the existing example configuration and copy the yaml from this file https://github.com/synpse-hq/slurm-cluster/blob/main/mini/mini-slurm.yaml and click "Deploy".

This will create:

- A Slurm head node with Jupyter from which you can launch jobs
- Slurm controller node
- Slurmdbd node which acts as a database backend
- MariaDB database
- 3 compute nodes which will run the jobs

Data is mounted from `/data/slurm` host directory and is used to imitate a shared storage between the components. In multi-node deployment this would be backed by NFS or similar shared filesystems.

## Connecting to Slurm

With Slurm you will normally interact using `sbatch` and `sacct` commands. For that we have provided the container that has Jupyter but to access it, you first need to access the machine.

### Install and configure CLI

To install CLI, run:

```
curl https://downloads.synpse.net/install-cli.sh | bash
```

Then, go to your profile page https://cloud.synpse.net/profile and click on "New API Key", this will show you the command how to authenticate.

### Connect to Slurm Jupyter node

With CLI configured, run:

```
synpse device proxy mini-slurm 8888:8888
```

This creates a secure tunnel to our Slurm cluster machine, open it on http://localhost:8888:

![](https://github.com/synpse-hq/slurm-cluster/blob/main/static/jupyter.png)

Start a terminal in Jupyter and run some jobs!

## Running a Slurm job

You can find some examples here: https://slurm.schedmd.com/sbatch.html.

For example, let's create a file `job.sh` with contents:

```
#!/bin/bash
#
#SBATCH --job-name=test-job
#SBATCH --output=result.out
#
#SBATCH --ntasks=6
#

echo hello slurm
```

Now, to run it:

```bash
sbatch job.sh
```

You should see something like:

```root@slurmjupyter:/home/admin# sbatch job.sh 
Submitted batch job 11
```

and to see the results:

```
cat result.out 
hello slurm
```

## Hacking

You can check `Makefile` for image build targets. Set your `REGISTRY=my-own-registry` and then run:

```
make all
```

This will rebuild all Docker images. 

### Adding more packages into the workers

You can edit the docker/node/Dockerfile and add more packages into the image. Then, rebuild the images, restart your application and you have it :)

## Troubleshooting

#### Somehow slurm master was stopped? Had to SSH, exec into the slurmmaster container and start the service within it

Either restart the whole Slurm or just docker exec into the slurmmaster container and restart the service:

```
root@slurmmaster:~# service slurmctld start
 * Starting slurm central management daemon slurmctld  
```

#### No cluster issues in the database

```
port is set but still seeing error: "slurmdbd: error: _add_registered_cluster: trying to register a cluster (cluster) with no remote port" in the slurmdbd logs
```

Check cluster and then create it if it doesn't exist:

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



