#!/bin/bash
set -e

echo "starting up mpush..."
${MPUSH_ALLOC_HOME}/bin/mp.sh start 

sleep 5

shutdown_mpush_alloc() {
    echo "Shutting down mpush..."
    ${MPUSH_ALLOC_HOME}/bin/mp.sh stop
}

trap shutdown_mpush_alloc SIGINT SIGTERM EXIT
tail -f ${MPUSH_ALLOC_HOME}/logs/mpush.out
