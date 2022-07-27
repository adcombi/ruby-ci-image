#!/bin/bash
set -e

exec gosu app "$@"
