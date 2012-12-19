#!/bin/sh

set -o errexit

xcodebuild -target "UT-GameOfLife" -configuration Debug -sdk iphonesimulator build
xcodebuild -target "AT-GameOfLife" -configuration Debug -sdk iphonesimulator build
xcodebuild -target "GameOfLife" -configuration Debug -sdk iphonesimulator build
