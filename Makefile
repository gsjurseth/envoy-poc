HOME := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
GCRPATH := eu.gcr.io/geirs-purdy-project
VERSION := 1.0

build-images: build-foo build-bar

build-foo:
	@cd $(HOME)/src/foo ; docker build -t apigee-foo . 

build-bar:
	@cd $(HOME)/src/bar ; docker build -t apigee-bar .

tag-foo: build-foo
	docker tag apigee-foo $(GCRPATH)/apige-foo:$(VERSION)

tag-bar: build-bar
	docker tag apigee-bar $(GCRPATH)/apige-bar:$(VERSION)

push-foo: tag-foo
	@echo "docker push $(GCRPATH)/apige-foo:$(VERSION)"

push-bar: tag-bar
	@echo "docker push $(GCRPATH)/apige-bar:$(VERSION)"

push: push-foo push-bar
