#!/bin/sh

# MIT License
#
# Copyright (c) 2020 Stockfiller AB
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

if [ -n "${PARAM_WORKING_DIR}" ]; then
    WORKING_DIR="--working-dir=${PARAM_WORKING_DIR}"
else
    WORKING_DIR=""
fi

if [ "${PARAM_PREFER_DIST}" = "true" ]; then
    PREFER_DIST="--prefer-dist"
else
    PREFER_DIST=""
fi

if [ "${PARAM_NO_SCRIPTS}" = "true" ]; then
    NO_SCRIPTS="--no-scripts"
else
    NO_SCRIPTS=""
fi

if [ "${PARAM_IGNORE_PLATFORM_REQS}" = "true" ]; then
    IGNORE_PLATFORM_REQS="--ignore-platform-reqs"
else
    IGNORE_PLATFORM_REQS=""
fi

if [ "${PARAM_NO_DEV}" = "true" ]; then
    NO_DEV="--no-dev"
else
    NO_DEV=""
fi

if [ "${PARAM_CLASSMAP_AUTHORITATIVE}" = "true" ]; then
    CLASSMAP_AUTHORITATIVE="--classmap-authoritative"
else
    CLASSMAP_AUTHORITATIVE=""
fi

if [ "${PARAM_OPTIMIZE_AUTOLOADER}" = "true" ]; then
    OPTIMIZE_AUTOLOADER="--optimize-autoloader"
else
    OPTIMIZE_AUTOLOADER=""
fi

if [ -z "${PARAM_CACHE_VERSION}" ]; then
    CACHE_VERSION="--no-cache"
else
    CACHE_VERSION=""
fi

FLAGS="${WORKING_DIR}" \
    " ${PREFER_DIST}" \
    " ${NO_SCRIPTS}" \
    " ${IGNORE_PLATFORM_REQS}" \
    " ${NO_DEV}" \
    " ${CLASSMAP_AUTHORITATIVE}" \
    " ${OPTIMIZE_AUTOLOADER}" \
    " ${CACHE_VERSION}"
# Strip leading whitespace
FLAGS=${FLAGS## }

echo "Running command \"${PARAM_BIN}\" with flags \"${FLAGS}\""

"${PARAM_BIN}" install --no-interaction "${FLAGS}"
