#!/bin/sh

set -o errexit

xcodebuild -target "UT-GameOfLife" -configuration Debug -sdk iphonesimulator build
xcodebuild -target "AT-GameOfLife" -configuration Debug -sdk iphonesimulator build
xcodebuild -target "GameOfLife" -configuration Debug -sdk iphonesimulator build

export NSDebugEnabled=YES
export NSZombieEnabled=YES
export NSDeallocateZombies=NO
export NSHangOnUncaughtException=YES
export NSAutoreleaseFreedObjectCheckEnabled=YES
export GHUNIT_AUTORUN=1

/usr/local/bin/ios-sim launch build/Debug-iphonesimulator/UT-GameOfLife.app --family ipad --exit
#/usr/local/bin/ios-sim launch build/Debug-iphonesimulator/AT-GameOfLife.app --family ipad
