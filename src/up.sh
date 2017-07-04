#!/usr/bin/env bash

source ./.parameters-azure
source ./.configuration

function access_logging
{
DATE=$(date +%b" "%e" "%H":"%M)
echo $DATE "nvidia-smi has been run" >>$LOG_ACCESS
exit 0
}

function error_logging
{
DATE=$(date +%b" "%e" "%H":"%M)
echo $DATE "Could not run nvidia-smi" >>$LOG_ERROR
exit 0
}

function ftp-upload
{
cd $OUTPUT_GPU_DIR

lftp -u $USER,$PASSWD $HOST << EOF

cd $REMOTE_FOLDER

put $OUTPUT_GPU_FILE

bye
EOF
exit 0
}

nvidia-smi > $OUTPUT_GPU_DIR$OUTPUT_GPU_FILE
if [ $? -eq 0 ]; then
    acces_logging
    ftp-upload
else
    error_logging
fi
