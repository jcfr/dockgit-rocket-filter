#
# Parameters
#

# Name of the docker executable
DOCKER = docker

# Docker organization to pull the images from
ORG = jcfr

# Name of image
IMAGE = dockgit-rocket-filter

build:
	docker build -t $(ORG)/$(IMAGE) .

push:
	docker push $(ORG)/$(IMAGE)
