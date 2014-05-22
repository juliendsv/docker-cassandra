#!/bin/bash

source install/common.sh

check_usage $# 1 "Usage: $0 <VERSION>"

VERSION=$1
IMAGE=cassandra:$VERSION

test_image $VERSION

if docker ps | grep $IMAGE >/dev/null; then
	cids=$(docker ps | grep $IMAGE | awk '{ print $1 }')
	echo $cids | xargs echo "Killing and removing containers"
	docker kill $cids > /dev/null
	docker rm $cids   > /dev/null
fi
