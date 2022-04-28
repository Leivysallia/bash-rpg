#!/bin/bash

source functions
source vars

if [[ -f mc ]]; then
   cat mc > save
   cat /dev/null > mc
fi

d20 vit_roll

echo $vit_roll

while [[ $vit -lt 7 ]]; do
vit=$(( (1 + RANDOM % 10) + (1 + RANDOM % 6) + (1 + RANDOM % 4) ))
done
while [[ $atk -lt 3 ]]; do
atk=$(( (1 + RANDOM % 6) + (1 + RANDOM % 4) ))
done
while [[ $def -lt 3 ]]; do
def=$(( (1 + RANDOM % 6) + (1 + RANDOM % 4) ))
done
while [[ $agi -lt 2 ]]; do
agi=$(( (1 + RANDOM % 6) ))
done
echo "PLAYER" >> mc
echo "VIT=$vit" >> mc
echo "ATK=$atk" >> mc
echo "DEF=$def" >> mc
echo "AGI=$agi" >> mc

cat mc