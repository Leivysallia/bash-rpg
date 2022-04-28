#!/bin/bash

SEED=$(date +%s%N)

RANDOM=$(date +%Y%m%d%I%M%S%N)

RANDOM=$((RANDOM ** SEED))

while IFS=: read -r name vit atk agi def exp syl; do
	echo "NAME=$name" >> "$name"
	echo "VIT=$vit" >> "$name"
	echo "ATK=$atk" >> "$name"
	echo "AGI=$agi" >> "$name"
	echo "DEF=$def" >> "$name"
	echo "EXP=$exp" >> "$name"
	echo "SYL=$syl" >> "$name"
done < bestiary