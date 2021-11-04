#!/usr/bin/env bash

set -euo pipefail

GOOS="linux" go build -ldflags='-s -w' -tags osusergo -o bin/helper github.com/paketo-buildpacks/open-liberty/cmd/helper
GOOS="linux" go build -ldflags='-s -w' -tags osusergo -o bin/main github.com/paketo-buildpacks/open-liberty/cmd/buildpack

if [ "${STRIP:-false}" != "false" ]; then
  strip bin/main
fi

if [ "${COMPRESS:-none}" != "none" ]; then
  $COMPRESS bin/main
fi

ln -fs main bin/build
ln -fs main bin/detect
