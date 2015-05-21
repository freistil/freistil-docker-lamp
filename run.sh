#!/bin/bash

for startupscript in /setup/*-setup.sh; do
  echo "=> Executing $startupscript"
  $startupscript
done

exec supervisord -n
