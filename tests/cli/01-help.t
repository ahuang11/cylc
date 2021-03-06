#!/bin/bash
# THIS FILE IS PART OF THE CYLC SUITE ENGINE.
# Copyright (C) 2008-2018 NIWA
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#-------------------------------------------------------------------------------
# cylc help and basic invocation.

. "$(dirname "$0")/test_header"
set_test_number 45

# Top help
run_ok "${TEST_NAME_BASE}-0" cylc
run_ok "${TEST_NAME_BASE}-h" cylc h
run_ok "${TEST_NAME_BASE}--h" cylc h
run_ok "${TEST_NAME_BASE}-help" cylc help
run_ok "${TEST_NAME_BASE}---help" cylc --help
for FILE in \
    "${TEST_NAME_BASE}-h.stdout" \
    "${TEST_NAME_BASE}--h.stdout" \
    "${TEST_NAME_BASE}-help.stdout" \
    "${TEST_NAME_BASE}---help.stdout"
do
    cmp_ok "${FILE}" "${TEST_NAME_BASE}-0.stdout"
done

# Sub-command
run_ok "${TEST_NAME_BASE}-warranty" cylc warranty
run_ok "${TEST_NAME_BASE}-license-warranty" cylc license warranty
run_ok "${TEST_NAME_BASE}-GPL-warranty" cylc GPL warranty
run_ok "${TEST_NAME_BASE}-w" cylc w
run_ok "${TEST_NAME_BASE}-license-w" cylc license w
run_ok "${TEST_NAME_BASE}-GPL-w" cylc GPL w
for FILE in \
    "${TEST_NAME_BASE}-license-warranty.stdout" \
    "${TEST_NAME_BASE}-GPL-warranty.stdout" \
    "${TEST_NAME_BASE}-w.stdout" \
    "${TEST_NAME_BASE}-license-w.stdout" \
    "${TEST_NAME_BASE}-GPL-w.stdout"
do
    cmp_ok "${FILE}" "${TEST_NAME_BASE}-warranty.stdout"
done

# Sub-command - no match
run_fail "${TEST_NAME_BASE}-aardvark" cylc aardvark
run_fail "${TEST_NAME_BASE}-license-aardvark" cylc license aardvark
for FILE in \
    "${TEST_NAME_BASE}-aardvark.stderr" \
    "${TEST_NAME_BASE}-license-aardvark.stderr"
do
    cmp_ok "${FILE}" <<'__STDERR__'
cylc aardvark: unknown utility. Abort.
Type "cylc help all" for a list of utilities.
__STDERR__
done

# Sub-command - many matches
run_fail "${TEST_NAME_BASE}-get" cylc get
cmp_ok "${TEST_NAME_BASE}-get.stderr" <<'__STDERR__'
cylc get: is ambiguous for:
    cylc get-config
    cylc get-contact
    cylc get-cylc-version
    cylc get-directory
    cylc get-global-config
    cylc get-gui-config
    cylc get-site-config
    cylc get-suite-config
    cylc get-suite-contact
    cylc get-suite-version
__STDERR__

# Sub-command help
run_ok "${TEST_NAME_BASE}-warranty--help" cylc warranty --help
run_ok "${TEST_NAME_BASE}-warranty-h" cylc warranty -h
run_ok "${TEST_NAME_BASE}-help-warranty" cylc help warranty
run_ok "${TEST_NAME_BASE}-h-license-warranty" cylc h license warranty
run_ok "${TEST_NAME_BASE}---help-license-warranty" cylc --help license warranty
run_ok "${TEST_NAME_BASE}-help-w" cylc help w
run_ok "${TEST_NAME_BASE}-license-w" cylc help license w
for FILE in \
    "${TEST_NAME_BASE}-warranty-h.stdout" \
    "${TEST_NAME_BASE}-help-warranty.stdout" \
    "${TEST_NAME_BASE}-h-license-warranty.stdout" \
    "${TEST_NAME_BASE}---help-license-warranty.stdout" \
    "${TEST_NAME_BASE}-help-w.stdout" \
    "${TEST_NAME_BASE}-license-w.stdout"
do
    cmp_ok "${FILE}" "${TEST_NAME_BASE}-warranty--help.stdout"
done

# Version
run_ok "${TEST_NAME_BASE}-version" cylc version
run_ok "${TEST_NAME_BASE}---version" cylc --version
run_ok "${TEST_NAME_BASE}-V" cylc -V
run_ok "${TEST_NAME_BASE}-version.stdout" \
    test -n "${TEST_NAME_BASE}-version.stdout"
cmp_ok "${TEST_NAME_BASE}-version.stdout" "${TEST_NAME_BASE}---version.stdout"
cmp_ok "${TEST_NAME_BASE}-version.stdout" "${TEST_NAME_BASE}-V.stdout"

exit
