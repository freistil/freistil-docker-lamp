#!/bin/bash

/usr/bin/mysqld_safe > /dev/null 2>&1 &

RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for MySQL to start"
    sleep 5
    mysql -uroot -e "status" > /dev/null 2>&1
    RET=$?
done

echo "=> MySQL started"
