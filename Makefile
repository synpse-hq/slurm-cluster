VERSION ?= latest

slurmdbd:
	cd docker/slurmdbd && docker build -f Dockerfile -t ghcr.io/synpse-hq/slurmdbd:${VERSION} .

push-slurmdbd: slurmdbd
	docker push ghcr.io/synpse-hq/slurmdbd:${VERSION}