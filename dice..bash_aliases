#!/bin/bash

d20 () {

num=$1
	
cat /dev/null > roll
d=0
res=0
while [[ $num -gt 0 ]]; do

	d=$((1 + RANDOM % 20 ))

	echo $d >> roll
	res=$(( d + res ))

	num=$(( num - 1 ))

done



}