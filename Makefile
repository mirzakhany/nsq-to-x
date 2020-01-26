default: build_image

DOCKER_IMAGE ?= mirzakhani/nsq-to-x
DOCKER_TAG ?= `git rev-parse --abbrev-ref HEAD`

build_image:
	@docker build \
	  --build-arg VCS_REF=`git rev-parse --short HEAD` \
	  --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
	  -t $(DOCKER_IMAGE):$(DOCKER_TAG) .
	  
push_image:
	# Push image to DockerHub
	docker push $(DOCKER_IMAGE):$(DOCKER_TAG)
