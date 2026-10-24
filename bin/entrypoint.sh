#!/bin/bash
set -e

if [ -n "${CI_PROJECT_DIR:-}" ]; then
  chown -R :users "$CI_PROJECT_DIR"
fi

exec gosu app "$@"
