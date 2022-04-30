#!/bin/bash
name=DEBUG
source functions.bash
source vars.bash

if [[ -f mc ]]; then
   cat mc > save
   cat /dev/null > mc
fi

cleanstart
makeplayer

cat player.bash

enc

cat drawsnear.bash