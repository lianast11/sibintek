IMAGE_NAME := my-utility-image
VERSION := 1.0.0
DOCKER_REGISTRY := my-registry.com

.PHONY: build deploy clean

build:
	docker build -t $(DOCKER_REGISTRY)/$(IMAGE_NAME):$(VERSION) -t $(DOCKER_REGISTRY)/$(IMAGE_NAME):latest . 
	docker run --rm $(DOCKER_REGISTRY)/$(IMAGE_NAME):$(VERSION) yamllint myconfig.yaml
	docker run --rm $(DOCKER_REGISTRY)/$(IMAGE_NAME):$(VERSION) shellcheck myscript.sh
	@echo "Образ успешно собран."

deploy:
	docker login $(DOCKER_REGISTRY)
	docker push $(DOCKER_REGISTRY)/$(IMAGE_NAME):$(VERSION)
	docker push $(DOCKER_REGISTRY)/$(IMAGE_NAME):latest
	@echo "Образ успешно загружен в реестр."

clean:
	docker image rm $(DOCKER_REGISTRY)/$(IMAGE_NAME):$(VERSION) $(DOCKER_REGISTRY)/$(IMAGE_NAME):latest
	@echo "Образы успешно удалены с локального ПК."
