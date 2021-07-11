#!/bin/bash

# import common lib and settings
. "$HOME/.noaa-v2.conf"
. "$NOAA_HOME/scripts/common.sh"
APITOKEN=${PUSHOVER_APITOKEN}
USER=${PUSHOVER_USER}
PRIO=${PUSHOVER_PRIO}
TEXT=$1
SAT=$2

timeout 20 curl -s -k -d token=${APITOKEN} -d user=${USER} -d message="${TEXT}" -d title="${SAT}" -d priority=${PRIO} -d html=1 https://api.pushover.net/1/messages.json
