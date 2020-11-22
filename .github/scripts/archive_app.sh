#!/bin/bash

set -eo pipefail

xcodebuild -workspace Velo.xcodeproj \
            -scheme Velo \
            -sdk iphoneos \
            -configuration AppStoreDistribution \
            -archivePath $PWD/build/Calculator.xcarchive \
            clean archive | xcpretty
