#!/usr/bin/env sh
RUBY_IMAGE_TAG=$1

echo $RUBY_IMAGE_TAG

echo docker build --tag registry.adcombi.com:5000/adcombi/ruby-ci-image:$RUBY_IMAGE_TAG --build-arg ruby_version=$RUBY_IMAGE_TAG .
eval docker build --tag registry.adcombi.com:5000/adcombi/ruby-ci-image:$RUBY_IMAGE_TAG --build-arg ruby_version=$RUBY_IMAGE_TAG . || exit 1
echo docker push registry.adcombi.com:5000/adcombi/ruby-ci-image:$RUBY_IMAGE_TAG
eval docker push registry.adcombi.com:5000/adcombi/ruby-ci-image:$RUBY_IMAGE_TAG || exit 1

