#!/bin/bash
set -e

rm -rf $CI_PROJECT_DIR/node_modules/
chown -R app:app /builds/adcombi/
exec gosu app "$@"
