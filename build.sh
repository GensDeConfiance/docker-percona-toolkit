#!/bin/sh

IMAGE_NAME=gdc/percona-toolkit
TAG=$(cat version.txt)

docker build --build-arg PERCONA_TOOLKIT_VERSION="${TAG}" --pull -t "${IMAGE_NAME}:${TAG}" .
