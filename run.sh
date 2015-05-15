#!/bin/bash

/setup/mysql-setup.sh
/setup/php-setup.sh

exec supervisord -n
