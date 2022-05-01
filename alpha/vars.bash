#!/bin/bash

source functions.bash

SEED=$(date +%S%N)

echo $SEED > seed.bash

RANDOM=$SEED


export count=0

levelcalc

export stamina=$(( 1 + RANDOM % $level ))