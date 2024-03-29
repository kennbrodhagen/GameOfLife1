#!/bin/sh
##
# Copyright 2008-2012 Apple Inc.
# All rights reserved.
#
# iPhoneSimulator platform
# This script runs all of the unit tests for the target test bundle specified by the passed-in environment.
# This script is generally intended to be invoked by ${DEVELOPER_TOOLS_DIR}/RunUnitTests. The interface or location of this script may change in future releases.
##
#
# Input:
#   See ${DEVELOPER_TOOLS_DIR}/RunUnitTests for input variables

Message() {
# usage: Message line type message
# Echo the message to stdout as the given type of message and continue
    echo "${PLATFORM_DEVELOPER_TOOLS_DIR}/Tools/RunPlatformUnitTests:${1}: ${2}: ${3}"
}

Note() {
# usage: Notify line message
# Echo the message to stdout as a note and continue
    Message "${1}" note "${2}"
}

Warning() {
# usage: Warning line message
# Echo the message to stdout as a note and continue
    Message "${1}" warning "${2}"
}

Error() {
# usage: Notify line message
# Echo the message to stdout as an error and continue
    Message "${1}" error "${2}"
}

Fail() {
# usage: Fail line message
# Echo the message to stdout and return 1, the universal error code
    Error "${1}" "${2}"
    exit 1
}

### Do not run tests on anything but a "build".

if [ "${ACTION}" != "build" ]; then
    exit 0
fi

### Silently skip tests if TEST_AFTER_BUILD is NO

if [ "${TEST_AFTER_BUILD}" = "NO" ]; then
    exit 0
fi

### Source main RunPlatformUnitTests.include functionality

if [ "${DEVELOPER_TOOLS_DIR}" = "" ]; then
    Fail ${LINENO} "DEVELOPER_TOOLS_DIR is not set."
fi

if [ "${PLATFORM_DEVELOPER_TOOLS_DIR}" = "" ]; then
    Fail ${LINENO} "PLATFORM_DEVELOPER_TOOLS_DIR is not set."
fi

includeFile="${DEVELOPER_TOOLS_DIR}/RunPlatformUnitTests.include"
if [ ! -r "${includeFile}" ]; then
    Fail ${LINENO} "Cannot read include file ${includeFile}"
fi

source "${includeFile}"

if [ 0 != $? ]; then
    Fail ${LINENO} "Could not source include file ${includeFile}"
fi

### Simulator app testing isn't supported, so redefine RunTestsForApplication.

RunTestsForApplication() {
    export OTHER_TEST_FLAGS="-RegisterForSystemEvents" 
    RunTestsForApplication "${TEST_HOST}" "${TEST_BUNDLE_PATH}"    
}

### Source platform RunPlatformUnitTests.include functionality

includeFileRPUT="${PLATFORM_DEVELOPER_TOOLS_DIR}/RunPlatformUnitTests.include"

if [ -e "${includeFileRPUT}" ]; then
    if [ ! -r "${includeFileRPUT}" ]; then
        Fail ${LINENO} "Cannot read include file ${includeFileRPUT}"
    fi

    source "${includeFileRPUT}"

    if [ 0 != $? ]; then
        Fail ${LINENO} "Could not source include file ${includeFileRPUT}"
    fi
fi

### Define a sensible default for the path to the otest

if [ "${OTEST}" = "" ]; then
    OTEST="${SDKROOT}/Developer/usr/bin/otest"
fi

Main() {
# usage: Main
# Determine how tests need to be run and run them.
 
    # GC not supported by the simulator
    TEST_GC_STATES="OFF"
    
    Configure_TEST_ARCHS
    
    if [ "${TEST_HOST}" != "" ]; then
        # All applications are tested the same way, by injecting a bundle.
        # The bundle needs to configure and run the tests itself somehow.

        RunTestsForApplication "${TEST_HOST}" "${TEST_BUNDLE_PATH}"
    else
        # If no TEST_HOST is specified, assume we're running the test bundle.
        
        RunTestsForBundle "${TEST_BUNDLE_PATH}"
    fi
}

### Update the dyld environment to support running tests out of the build directory.

# Sets and exports the following environment variables:
#   DYLD_ROOT_PATH
#   DYLD_FRAMEWORK_PATH
#   DYLD_LIBRARY_PATH
#   DYLD_NEW_LOCAL_SHARED_REGIONS
#   DYLD_NO_FIX_PREBINDING

if [ "${DYLD_FRAMEWORK_PATH}" != "" ]; then
    DYLD_FRAMEWORK_PATH="${BUILT_PRODUCTS_DIR}:${SDKROOT}${DEVELOPER_LIBRARY_DIR}/Frameworks:${DYLD_FRAMEWORK_PATH}"
else
    DYLD_FRAMEWORK_PATH="${BUILT_PRODUCTS_DIR}:${SDKROOT}${DEVELOPER_LIBRARY_DIR}/Frameworks"
fi

if [ "${DYLD_LIBRARY_PATH}" != "" ]; then
    DYLD_LIBRARY_PATH="${BUILT_PRODUCTS_DIR}:${DYLD_LIBRARY_PATH}"
else
    DYLD_LIBRARY_PATH="${BUILT_PRODUCTS_DIR}"
fi

if [ "${DYLD_ROOT_PATH}" != "" ]; then
    DYLD_ROOT_PATH="${SDKROOT}:${DYLD_ROOT_PATH}"
else
    DYLD_ROOT_PATH="${SDKROOT}"
fi

DYLD_NEW_LOCAL_SHARED_REGIONS=YES
DYLD_NO_FIX_PREBINDING=YES
IPHONE_SIMULATOR_ROOT=$SDKROOT		## rdar://6528939
CFFIXED_USER_HOME="${HOME}/Library/Application Support/iPhone Simulator/$IPHONESIMULATOR_PLATFORM_VERSION"

EXPORT_VARS=(DYLD_FRAMEWORK_PATH DYLD_LIBRARY_PATH DYLD_NEW_LOCAL_SHARED_REGIONS DYLD_NO_FIX_PREBINDING DYLD_ROOT_PATH IPHONE_SIMULATOR_ROOT CFFIXED_USER_HOME )

### Run the tests

Main
