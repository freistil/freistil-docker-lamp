# Image-specific settings
IMAGE_NAME = freistil/lamp
RUN_OPTS = -i -t -p :80 -p :3306

# Determine current Git commit
GIT_SHA := $(shell git rev-parse HEAD)

# Build the image
build:
	docker build -t ${IMAGE_NAME}:${GIT_SHA} .
	docker tag -f ${IMAGE_NAME}:${GIT_SHA} ${IMAGE_NAME}:latest

# Start a container from the image
run:
	docker run ${RUN_OPTS} ${IMAGE_NAME}:${GIT_SHA}

# Push to registry
push:
	docker push ${IMAGE_NAME}:latest
