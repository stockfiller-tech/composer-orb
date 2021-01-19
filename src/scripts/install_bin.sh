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

EXPECTED_CHECKSUM="$(php -r "echo file_get_contents('https://composer.github.io/installer.sig');")"
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_CHECKSUM="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

if [ "$EXPECTED_CHECKSUM" != "$ACTUAL_CHECKSUM" ]; then
    echo >&2 'ERROR: Invalid installer checksum'
    rm composer-setup.php
    exit 1
fi

if [ -n "${PARAM_FILENAME}" ]; then
    set -- "$@" "--filename=${PARAM_FILENAME}"
fi

if [ -n "${PARAM_INSTALL_DIR}" ]; then
    set -- "$@" "--install-dir=${PARAM_INSTALL_DIR}"
fi

if [ -n "${PARAM_VERSION}" ]; then
    set -- "$@" "--version=${PARAM_VERSION}"
fi

echo "Installing Composer with flags: " "$@"

php composer-setup.php --quiet "$@"
RESULT=$?
rm composer-setup.php
exit $RESULT
