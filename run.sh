#!/bin/bash

for initscript in /setup/init/*.sh; do
  echo "=> Executing $initscript"
  $initscript
done

exec supervisord -n
