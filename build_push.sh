#!/usr/bin/env sh
RUBY_IMAGE_TAG=$1

echo $RUBY_IMAGE_TAG

docker build --tag registry.gitlab.com/adcombi/ruby-ci-image:$RUBY_IMAGE_TAG --build-arg ruby_version=$RUBY_IMAGE_TAG .
docker push registry.gitlab.com/adcombi/ruby-ci-image:$RUBY_IMAGE_TAG
