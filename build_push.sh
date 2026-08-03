#!/usr/bin/env sh
set -eu

IMAGE_REPO="ghcr.io/adcombi/ruby-ci-image"
RUBY_IMAGE_TAG=${1:-}
# Default to multi-arch so pushes from any machine (incl. Apple Silicon) always
# contain linux/amd64 for the CI runners. Override with PLATFORMS=... if needed.
PLATFORMS=${PLATFORMS:-linux/amd64,linux/arm64}

if [ -z "${RUBY_IMAGE_TAG}" ]; then
  echo "Usage: ./build_push.sh <ruby_version_tag>"
  echo "Example: ./build_push.sh 3.4.10"
  exit 1
fi

echo "Building ${IMAGE_REPO}:${RUBY_IMAGE_TAG} for platform(s): ${PLATFORMS}"

# Ensure a buildx builder exists and is selected
docker buildx inspect >/dev/null 2>&1 || docker buildx create --use >/dev/null

docker buildx build \
  --platform "${PLATFORMS}" \
  --tag "${IMAGE_REPO}:${RUBY_IMAGE_TAG}" \
  --build-arg ruby_version="${RUBY_IMAGE_TAG}" \
  --push \
  .

# Verify the pushed manifest actually contains linux/amd64 (the CI runner architecture)
docker buildx imagetools inspect "${IMAGE_REPO}:${RUBY_IMAGE_TAG}" | grep -q 'linux/amd64' || { echo "ERROR: ${IMAGE_REPO}:${RUBY_IMAGE_TAG} is missing linux/amd64"; exit 1; }
