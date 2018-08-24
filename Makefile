IMAGE_NAME ?= glynhanmer/go-linters
GOLANG_BUILDER_TAG ?= 1.10.3-alpine3.7
GOLINTERS_IMAGE ?= $(IMAGE_NAME):$(GOLANG_BUILDER_TAG)

image:
	docker build -t $(GOLINTERS_IMAGE) --build-arg GOLANG_BUILDER_TAG=$(GOLANG_BUILDER_TAG) .

tag-as-latest:
	docker tag $(GOLINTERS_IMAGE) $(IMAGE_NAME):latest

run:
	$(if $(value PACKAGE),,$(error PACKAGE not set))
	docker run --rm -v $(GOPATH)/src/$(PACKAGE):/go/src/$(PACKAGE) -e GO_GET=$(GO_GET) -w /go/src/$(PACKAGE) $(IMAGE_NAME)