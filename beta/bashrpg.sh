#!/bin/bash

source functions.bash
source vars.bash

cleanstart

newline

while [[ $vit -gt 0 ]]; do

if [[ $stamina -eq 0 ]]; then
   levelcalc
   day=$(( day + 1 ))
   heal
stamina=$(( 1 + RANDOM % $level ))
fi

render |log

newline

read -n1 -r -p $'What Action? [1-3]:\n' act

while [[ $act -gt $stamina ]]; do
   newline
   echo $'Not Enough Stamina:\n'
   read -n1 -r -p $'What Action? [1-3]:\n' act
   newline
done


while [[ $act -gt 3 || $act -lt 1 ]]; do
   newline
   echo $'Invalid Input:\n'
   read -n1 -r -p $'What Action? [1-3]:\n' act
   newline
done

newline

if [[ $act -eq 2 ]]; then
   stamina=$(( stamina - 2 ))
   move

fi

if [[ $act -eq 1 ]]; then

   if [[ $count -le 3 ]]; then 
   stamina=$(( stamina - 1 ))
   rest
else
   echo "Too much rest. Time to move..."
   fi

fi


if [[ $act -eq 3 ]]; then
stamina=$(( stamina - 3 ))

   save

fi

done