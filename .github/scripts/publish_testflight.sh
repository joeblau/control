#!/bin/bash

set -eo pipefail

xcrun altool --upload-app -t ios -f build/Velo.ipa -u "$APPLEID_USERNAME" -p "$APPLEID_PASSWORD" --verbose
