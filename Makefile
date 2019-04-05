ARCH_FLAG := GOARCH=amd64
ENV_FLAGS = CGO_ENABLED=0 $(ARCH_FLAG)

BUILD_CMD := go build
BINARY_NAME := jenTest
BUILD_FLAGS = -o $(BINARY_NAME)
TAG_BASE = ankitm1234/cra-jenkins:
TAG_LATEST := $(TAG_BASE)latest

default: build-go

build-go:
	$(ENV_FLAGS) $(BUILD_CMD) $(BUILD_FLAGS)

dockerize: build-go
	docker build -t $(TAG_LATEST) .
dockerpush: dockerize
	docker push $(TAG_LATEST)