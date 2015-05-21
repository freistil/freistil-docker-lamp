#!/bin/bash

chmod 755 /run.sh /setup/init/*.sh /setup/init/*/*.sh

for initscript in /setup/init/*.sh; do
  echo "=> Executing $initscript"
  $initscript
done

exec supervisord -n
