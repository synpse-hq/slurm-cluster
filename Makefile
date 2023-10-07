VERSION ?= 22.04

jupyter:
	docker build -f docker/jupyter/Dockerfile --platform linux/amd64 -t ghcr.io/synpse-hq/slurm-jupyter:${VERSION} .

push-jupyter: jupyter
	docker push ghcr.io/synpse-hq/slurm-jupyter:${VERSION}

master:
	docker build -f docker/master/Dockerfile --platform linux/amd64 -t ghcr.io/synpse-hq/slurm-master:${VERSION} .

push-master: master
	docker push ghcr.io/synpse-hq/slurm-master:${VERSION}

node:
	cd docker/node && docker build -f Dockerfile --platform linux/amd64 -t ghcr.io/synpse-hq/slurm-node:${VERSION} .

push-node: node
	docker push ghcr.io/synpse-hq/slurm-node:${VERSION}

slurmdbd:
	docker build -f docker/slurmdbd/Dockerfile --platform linux/amd64 -t ghcr.io/synpse-hq/slurmdbd:${VERSION} .

push-slurmdbd: slurmdbd
	docker push ghcr.io/synpse-hq/slurmdbd:${VERSION}


# Build and push all images
all: push-node push-master push-jupyter push-slurmdbd