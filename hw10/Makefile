# Define variables
REPO_URL = git@github.com:yuriipaneiko/ShortMe-URL-Shortener.git
IMAGE_NAME = shortme2

# Default target
all: build run

# Target to clone the Git repository
clone:
	git clone $(REPO_URL) app

# Target to build the Docker image
build: clone
	docker build -t $(IMAGE_NAME) ./app

# Target to run the Docker container
run:
	docker run -d -p 5000:5000 $(IMAGE_NAME)

# Target to clean up cloned repository and Docker image
clean:
	rm -rf ./app
	docker rmi $(IMAGE_NAME)

# PHONY targets (targets that are not filenames)
.PHONY: all clone build run clean
