#!/bin/bash

source functions.bash

SEED=$(date +%S%N)

echo $SEED > seed.bash

RANDOM=$SEED

export pid=DEBUG

export day=1

export count=0

levelcalc

export stamina=$(( 1 + RANDOM % $level ))

export natwenty=0

export thresh=$(( ( 1 + RANDOM % $level ) * ( 1 + RANDOM % $level ) * ( 1 + RANDOM % $level ) ))