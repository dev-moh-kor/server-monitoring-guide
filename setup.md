# Setup upload script for Azure

This document describes how to configure the upload script for AI-monitoring

## precondition


### Install on Ubuntu

Install lftp:

```
$ sudo apt-get -y install lftp
```

More information [lftp website](http://lftp.tech/)

# Usage

There are two file(s) 

* upload.sh
* .parameters-azure
* .configuration

## upload.sh

Within the upload.sh there are four configurations

## .parameters-azure

Here you configure the credentials for Azure

USER=''<br/>
Username of the external account

PASSWD=''<br/>
Password external account

## .configuration

Within this file the basic configuration can be found.

OUTPUT_GPU_DIR=''<br/>
The location where the output file should be created

OUTPUT_GPU_FILE=''<br/>
The name of the output file

LOG_ERROR=''<br/>
The location of the error logging of the upload script

LOG_ACCESS=''<br/>
The location of the access logging of the upload script

HOST=''<br/>
To which system you want to connect

REMOTE_FOLDER=''<br/>
The location where the file must be placed on the external server.

# Installation
Download the src directory. Make the .parameters-azure file read-only for the user which will execute the upload.sh.

Make up.sh and .parameters-azure executable.
```
$ chmod 700 up.sh
$ chmod 700 .paramaeters-azure
$ chmod 700 .configuration
```

# Remarks

When running the application as you're own user will create the log file(s) under you're
user id. When running the application under another user will give an conflict in rights. Be aware of this.
