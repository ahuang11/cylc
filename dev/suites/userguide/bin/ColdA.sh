#!/bin/bash

set -e

cylc checkvars  TASK_EXE_SECONDS
cylc checkvars -c A_RUNNING_DIR

echo "Hello from $TASK_NAME at $CYCLE_TIME in $CYLC_SUITE_NAME"
sleep $TASK_EXE_SECONDS

touch $A_RUNNING_DIR/A-${CYCLE_TIME}.restart
