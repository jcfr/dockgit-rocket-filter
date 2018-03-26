#
# Parameters
#

# Name of the docker executable
DOCKER = docker

# DockerHub organization and repository to pull/push the images from/to
ORG = jcfr
REPO = dockgit-rocket-filter

build:
	$(eval IMAGEID := $(shell $(DOCKER) images -q $(ORG)/$(REPO)))
	docker build \
		--build-arg IMAGE=$(REPO) \
		--build-arg VCS_REF=`git rev-parse --short HEAD` \
		--build-arg VCS_URL=`git config --get remote.origin.url` \
		--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
		-t $(ORG)/$(REPO) .
	CURRENT_IMAGEID=$$($(DOCKER) images -q $(ORG)/$(REPO)) && \
	if [ -n "$(IMAGEID)" ] && [ "$(IMAGEID)" != "$$CURRENT_IMAGEID" ]; then $(DOCKER) rmi "$(IMAGEID)"; fi

push:
	docker push $(ORG)/$(REPO)
