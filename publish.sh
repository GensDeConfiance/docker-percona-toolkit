#!/bin/sh

usage () {
    echo "NAME"
    echo "    publish.sh -- push docker image to registry\n"
    echo "SYNOPSIS"
    echo "    publish.sh [options]\n"
    echo "DESCRIPTION"
    echo "    publish.sh is a tool for pushing the docker image to registry\n"
    echo "OPTIONS"
    echo "    -h, --help"
    echo "        Usage help. This lists all current command line options with a short description.\n"
    echo "    --latest"
    echo "        Also push/update the latest tag.\n"
    echo "AUTHORS / CONTRIBUTORS"
    echo "    François-Xavier de Guillebon is the main author."
}

while [ $# -gt 0 ]
do
    case $1 in
    -h | --help)
        usage
        exit
        ;;
    --latest)
        PUSH_LATEST=1
        ;;
    esac
    shift
done

IMAGE_NAME=gdc/percona-toolkit
REGISTRY=814784874698.dkr.ecr.eu-west-1.amazonaws.com
TAG=$(cat version.txt)

if [ -n "${PUSH_LATEST}" ]; then
    docker tag "${IMAGE_NAME}:${TAG}" "${REGISTRY}/${IMAGE_NAME}:latest"
    docker push "${REGISTRY}/${IMAGE_NAME}:latest"
fi

docker tag "${IMAGE_NAME}:${TAG}" "${REGISTRY}/${IMAGE_NAME}:${TAG}"
docker push "${REGISTRY}/${IMAGE_NAME}:${TAG}"
