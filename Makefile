#!make
include .env
export

image := $(IMAGE_NAME)
tag := $(DEFAULT_TAG)
registry := $(AWS_CLIENT_ID).dkr.ecr.$(AWS_ECR_REGION).amazonaws.com/$(image)

all: build push

build:
	$(info Building image... )
	docker build \
		--file=./.docker/Dockerfile \
		--no-cache \
		--pull \
		--compress \
		--rm -t $(image):$(tag) .

push:
	$(info Tagging image... )
	docker tag $(image):$(tag) $(registry):$(tag)

	$(info Pushing image to ECR... )
	docker push $(registry):$(tag)
