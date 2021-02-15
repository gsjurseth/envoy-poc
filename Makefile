HOME := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
GCRPATH := eu.gcr.io/geirs-purdy-project
VERSION := latest

build-images: build-foo build-bar

build-foo:
	@cd $(HOME)/src/foo ; docker build -t apigee-foo . 

build-bar:
	@cd $(HOME)/src/bar ; docker build -t apigee-bar .

tag-foo: build-foo
	docker tag apigee-foo $(GCRPATH)/apigee-foo:$(VERSION)

tag-bar: build-bar
	docker tag apigee-bar $(GCRPATH)/apigee-bar:$(VERSION)

push-foo: tag-foo
	@echo "docker push $(GCRPATH)/apigee-foo:$(VERSION)"

push-bar: tag-bar
	@echo "docker push $(GCRPATH)/apigee-bar:$(VERSION)"

push: push-foo push-bar
