#!/bin/bash
set -e

if [ -f "bin/foedus" ]; then
    bin/foedus eval "Foedus.Release.migrate" || true
    bin/foedus start
else
    exec "$@"
fi
