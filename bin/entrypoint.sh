#!/bin/bash
set -e

rm -rf $CI_PROJECT_DIR/node_modules/
exec gosu app "$@"
