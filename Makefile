IMAGE_NAME := my-utility-image
VERSION := 1.0.0
DOCKER_REGISTRY := my-registry.com

.PHONY: build deploy clean

build:
	docker build -t $(DOCKER_REGISTRY)/$(IMAGE_NAME):$(VERSION) -t $(DOCKER_REGISTRY)/$(IMAGE_NAME):latest . 
	docker run --rm $(DOCKER_REGISTRY)/$(IMAGE_NAME):$(VERSION) yamllint myconfig.yaml
	docker run --rm $(DOCKER_REGISTRY)/$(IMAGE_NAME):$(VERSION) shellcheck myscript.sh
	@echo "Image successfully built."

deploy:
	docker login $(DOCKER_REGISTRY)
	docker push $(DOCKER_REGISTRY)/$(IMAGE_NAME):$(VERSION)
	docker push $(DOCKER_REGISTRY)/$(IMAGE_NAME):latest
	@echo "Image successfully pushed to the registry."

clean:
	docker image rm $(DOCKER_REGISTRY)/$(IMAGE_NAME):$(VERSION) $(DOCKER_REGISTRY)/$(IMAGE_NAME):latest
	@echo "The images have been successfully removed from the local machine."
