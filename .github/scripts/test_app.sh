#!/bin/bash

set -eo pipefail

xcodebuild -project Velo.xcodeproj \
            -scheme Velo \
            -destination platform=iOS\ Simulator,OS=14.0,name=iPhone\ 11 \
            clean test | xcpretty
