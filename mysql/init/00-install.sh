#!/bin/bash

VOLUME_HOME="/var/lib/mysql"

if [[ ! -d $VOLUME_HOME/mysql ]]; then
    echo "=> Initialising MySQL volume"
    mysql_install_db > /dev/null 2>&1
fi
