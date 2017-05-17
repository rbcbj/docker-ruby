PROJECT ?= robsonjr
TAG     ?= ruby
IMAGE=$(PROJECT):$(TAG)

all:
	@echo "Available targets:"
	@echo "  * build - build a Docker image for $(IMAGE)"

build: Dockerfile
	docker build -t $(IMAGE) .