#!/bin/bash
set -e

chown -R :users $CI_PROJECT_DIR
exec gosu app "$@"
