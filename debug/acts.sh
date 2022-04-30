#!/bin/bash

mov=0
source functions.bash
source vars.bash

echo $'Actions:'
echo $'1. Move'
echo $'2. Rest'

read -n1 -r -p $'What Action? [1-2]:\n' act
while [[ $act -gt 2 || $act -lt 1 ]]; do
	echo $'Invalid Input:\n'
	read -n1 -r -p $'What Action? [1-3]:\n' act
done

echo $'\n'

if [[ $act -eq 1 ]]; then

move

fi

if [[ $act -eq 2 ]]; then

rest

fi
