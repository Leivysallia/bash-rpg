#!/bin/bash

SEED=$(date +%s%N)

RANDOM=$(date +%Y%m%d%I%M%S%N)

RANDOM=$((RANDOM ** SEED))