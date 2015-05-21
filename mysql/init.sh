#!/bin/bash

for initscript in /setup/init/mysql/*.sh; do
  echo "=> Executing $initscript"
  $initscript
done
