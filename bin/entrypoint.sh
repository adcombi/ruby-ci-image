#!/bin/bash
set -e

chown -R app:app $CI_PROJECT_DIR
exec gosu app "$@"
