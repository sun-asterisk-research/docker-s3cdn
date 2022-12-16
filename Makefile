TAG ?= latest 2.9.6
REGISTRY ?= ghcr.io
IMAGE_NAME ?= sun-asterisk-research/s3cdn

.PHONY: all

all: $(TAG)

push: $(foreach tag,$(TAG),push-${tag})

$(TAG):
	docker build . \
		-f docker/Dockerfile \
		--build-arg TAG=$@ \
		-t ghcr.io/sun-asterisk-research/s3cdn:$@

push-%:
	docker push ghcr.io/sun-asterisk-research/s3cdn:$*
