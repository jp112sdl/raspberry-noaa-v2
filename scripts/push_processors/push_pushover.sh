#!/bin/bash

# import common lib and settings
. "$HOME/.noaa-v2.conf"
. "$NOAA_HOME/scripts/common.sh"
APITOKEN=${PUSHOVER_APITOKEN}
USER=${PUSHOVER_USER}
PRIO=${PUSHOVER_PRIO}
TEXT=$1
SAT=$2
FILELIST=$3
push_attachment_file=""

for singlefile in $FILELIST; do
 if [[ $singlefile == *"-122-rectified"* ]]; then
   push_attachment_file=$singlefile
   break
 fi
 if [[ $singlefile == *"MSA"* ]]; then
   push_attachment_file=$singlefile
   break
 fi
 if [[ $singlefile == *"MCIR"* ]]; then
   push_attachment_file=$singlefile
 fi
done

push_attachment=""
if [ -f "$push_attachment_file" ] && [ ! -z push_attachment_file ]; then
  push_attachment="-F attachment=@${push_attachment_file}"
else
  log "Pushover - no image to attach!" "WARN"
fi

log "Pushing to Pushover" "INFO"
log "Pushover filelist: ${FILELIST}" "INFO"
log "Pushover is using attachment: ${push_attachment_file}" "INFO"


# timeout 20 curl -s -k -d token=${APITOKEN} -d user=${USER} -d message="${TEXT}" -d title="${SAT}" -d priority=${PRIO} -d html=1 https://api.pushover.net/1/messages.json
timeout 20 curl -s -k --form-string "token=${APITOKEN}" --form-string "user=${USER}" --form-string "message=${TEXT}" --form-string "title=${SAT}" --form-string "priority=${PRIO}" --form-string "html=1" ${push_attachment} https://api.pushover.net/1/messages.json

