VERSION ?= 22.04
REGISTRY ?= ghcr.io/synpse-hq

jupyter:
	docker build -f docker/jupyter/Dockerfile --platform linux/amd64 -t ${REGISTRY}/slurm-jupyter:${VERSION} .

push-jupyter: jupyter
	docker push ${REGISTRY}/slurm-jupyter:${VERSION}

master:
	docker build -f docker/master/Dockerfile --platform linux/amd64 -t ${REGISTRY}/slurm-master:${VERSION} .

push-master: master
	docker push ${REGISTRY}/slurm-master:${VERSION}

node:
	docker build -f docker/node/Dockerfile --platform linux/amd64 -t ${REGISTRY}/slurm-node:${VERSION} .

push-node: node
	docker push ${REGISTRY}/slurm-node:${VERSION}

slurmdbd:
	docker build -f docker/slurmdbd/Dockerfile --platform linux/amd64 -t ${REGISTRY}/slurmdbd:${VERSION} .

push-slurmdbd: slurmdbd
	docker push ${REGISTRY}/slurmdbd:${VERSION}

# Compute nodes

# node-cpu:
# 	docker build -f docker/node/Dockerfile.cpu --platform linux/amd64 -t ${REGISTRY}/slurm-node:${VERSION}-cpu .

# push-node-cpu: node-cpu
# 	docker push ${REGISTRY}/slurm-node:${VERSION}-cpu

# Build and push all images
all: push-node push-master push-jupyter push-slurmdbd