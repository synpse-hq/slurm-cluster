VERSION ?= latest

slurmdbd:
	cd docker/slurmdbd && docker build -f Dockerfile --platform linux/amd64 -t ghcr.io/synpse-hq/slurmdbd:${VERSION} .

push-slurmdbd: slurmdbd
	docker push ghcr.io/synpse-hq/slurmdbd:${VERSION}