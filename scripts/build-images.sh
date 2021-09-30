#!/bin/bash

SCRIPT_DIR=$(cd `dirname $0` && pwd)
ROOT_DIR=$(dirname $SCRIPT_DIR)

DOCKER_DIR="${ROOT_DIR}/docker"

for dockerfile in $(ls $DOCKER_DIR) ; do

    dockerfile_abspath="${DOCKER_DIR}/${dockerfile}"

    plugin=$(echo $dockerfile | awk -F'-' '{ print $2 }')
    version=$(echo $dockerfile | awk -F'-' '{ print $3 }')

    image_tag="dbt-server-${plugin}-${version}"

    echo "Building from $dockerfile"
    echo "  Using tag=${image_tag}"
    docker build -f $dockerfile_abspath $ROOT_DIR  -t $image_tag

done
