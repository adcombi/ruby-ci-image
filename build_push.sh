#!/usr/bin/env sh
RUBY_IMAGE_TAG=$1

echo $RUBY_IMAGE_TAG

docker build --tag ghcr.io/adcombi/ruby-ci-image:$RUBY_IMAGE_TAG --build-arg ruby_version=$RUBY_IMAGE_TAG .
docker push ghcr.io/adcombi/ruby-ci-image:$RUBY_IMAGE_TAG
