VERSION ?= latest

slurmddb:
	cd docker/slurmdbd && docker build -f Dockerfile -t ghcr.io/synpse-hq/slurmdbd:${VERSION} .

push-slurmddb: slurmddb
	docker push ghcr.io/synpse-hq/slurmdbd:${VERSION}