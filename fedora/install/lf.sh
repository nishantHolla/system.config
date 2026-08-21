#!/bin/sh

set -euo pipefail
set -x

export GOPATH=$HOME/Go
env CGO_ENABLED=0 go install -trimpath -ldflags="-s -w" github.com/gokcehan/lf@latest
