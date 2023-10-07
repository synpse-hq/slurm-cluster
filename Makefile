VERSION ?= 22.04

slurmdbd:
	cd docker/slurmdbd && docker build -f Dockerfile --platform linux/amd64 -t ghcr.io/synpse-hq/slurmdbd:${VERSION} .

push-slurmdbd: slurmdbd
	docker push ghcr.io/synpse-hq/slurmdbd:${VERSION}


jupyter:
	cd docker/jupyter && docker build -f Dockerfile --platform linux/amd64 -t ghcr.io/synpse-hq/slurm-jupyter:${VERSION} .

push-jupyter: jupyter
	docker push ghcr.io/synpse-hq/slurm-jupyter:${VERSION}