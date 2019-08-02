.PHONY: help install docker.build docker.run docker.push

.DEFAULT_GOAL := help
DOCKERHUB_NAME := paveg
APP_NAME := dotfiles
VERSION_TAG := latest

help: ## Show options
	@grep -E '^[a-zA-Z_-{\.}]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

install: ## Install dotfiles
	./installer.sh

docker.build: ## Build docker image
	@docker build -t $(APP_NAME):$(VERSION_TAG) .

docker.run: ## Run on docker
	@docker run -it --rm $(APP_NAME):$(VERSION_TAG) zsh

docker.push: ## Push docker image
	@echo "push to $(DOCKERHUB_NAME)/$(APP_NAME):$(VERSION_TAG)"
	@docker tag $(APP_NAME):$(VERSION_TAG) $(DOCKERHUB_NAME)/$(APP_NAME):$(VERSION_TAG)
	@docker push  $(DOCKERHUB_NAME)/$(APP_NAME)
