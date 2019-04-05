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
	cp jenTest docker/ && chmod +x docker/jenTest
	if [ -d docker/build ]; \
	then \
		rm -rf docker/build; \
	fi
	cp -R build docker/
	docker build -t $(TAG_LATEST) docker/
dockerpush: dockerize
	docker push $(TAG_LATEST)