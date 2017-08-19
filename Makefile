DOCKER_IMAGE_VERSION=0.1.1
DOCKER_IMAGE_NAME=clayton/rpi-busybox-httpd-servehtml
DOCKER_IMAGE_TAGNAME=$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_VERSION)

default: build

build:
	dockerize -t $(DOCKER_IMAGE_NAME) \
		--add-file *.html /www/ \
		--entry '/bin/busybox' \
		--cmd 'httpd -p 80 -h /www' \
		/bin/busybox
	docker tag $(DOCKER_IMAGE_NAME) $(DOCKER_IMAGE_NAME):latest
	docker build -t clayton/rpi-busybox-httpd-servehtml .
	docker tag $(DOCKER_IMAGE_NAME) $(DOCKER_IMAGE_NAME):latest
	docker tag $(DOCKER_IMAGE_NAME) $(DOCKER_IMAGE_TAGNAME)

push:
	docker push $(DOCKER_IMAGE_NAME)

test:
	docker run --rm clayton/rpi-busybox-httpd-servehtml /bin/busybox echo "Success."
