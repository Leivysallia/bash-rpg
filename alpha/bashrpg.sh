#!/bin/bash

source functions.bash
source vars.bash

cleanstart

newline

while [[ $vit -gt 0 ]]; do

echo $'Actions:'
echo $'1. Move'
echo $'2. Rest'
echo $'3. Save'

read -n1 -r -p $'What Action? [1-3]:\n' act

while [[ $act -gt 3 || $act -lt 1 ]]; do
   newline
   echo $'Invalid Input:\n'
   read -n1 -r -p $'What Action? [1-3]:\n' act
   newline
done

newline

if [[ $act -eq 1 ]]; then

   move

fi

if [[ $act -eq 2 ]]; then

   if [[ $count -le 3 ]]; then 
   rest
else
   echo "Too much rest. Time to move..."
   fi
   
fi


if [[ $act -eq 3 ]]; then

   save

fi

done