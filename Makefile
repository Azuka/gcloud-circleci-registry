# Colors, because we want to be pretty
NO_COLOR=\033[0m
OK_COLOR=\033[32;01m
ERROR_COLOR=\033[31;01m
WARN_COLOR=\033[33;01m

# Container repo
REPOSITORY=gcr.io
PROJECT=deft-ocean-146214
IMAGE_NAME=${REPOSITORY}/${PROJECT}/gcloud-test
VERSION?=latest

# Build a container
.PHONY: container
container:
	@echo "${OK_COLOR}Building container${NO_COLOR}"
	@docker build  -t ${IMAGE_NAME}:${VERSION} .

# Push container to gcloud
.PHONY: push
push:
	@echo "${OK_COLOR}Pushing container to gcloud${NO_COLOR}"
	gcloud docker -- push ${IMAGE_NAME}:${VERSION}

# Run local circle-ci build
.PHONY: ci-circle
ci-circle:
	@echo "${OK_COLOR}Running circle locally${NO_COLOR}"
	@circleci \
		--tag 0.0.4171-0daf87a \
		-e GOOGLE_AUTH="${GOOGLE_AUTH}" \
		build
