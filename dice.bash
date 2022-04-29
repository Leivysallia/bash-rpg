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

d12 () {

num=$1
	
cat /dev/null > roll
d=0
res=0
while [[ $num -gt 0 ]]; do

	d=$((1 + RANDOM % 12 ))

	echo $d >> roll

	res=$(( d + res ))
	num=$(( num - 1 ))

done

}

d10 () {

num=$1
	
cat /dev/null > roll
d=0
res=0
while [[ $num -gt 0 ]]; do

	d=$((1 + RANDOM % 10 ))

	echo $d >> roll

	res=$(( d + res ))
	num=$(( num - 1 ))

done

}

d6 () {

num=$1
	
cat /dev/null > roll
d=0
res=0
while [[ $num -gt 0 ]]; do

	d=$((1 + RANDOM % 6 ))

	echo $d >> roll

	res=$(( d + res ))
	num=$(( num - 1 ))

done

}

d4 () {

num=$1
	
cat /dev/null > roll
d=0
res=0
while [[ $num -gt 0 ]]; do

	d=$((1 + RANDOM % 4 ))

	echo $d >> roll

	res=$(( d + res ))
	num=$(( num - 1 ))

done

}

makemon () {

	while read -r name base type; do
		echo "NAME=$name" >> $name
		echo "VIT=$(( (1 + RANDOM % $base) + (1 + RANDOM % $type) ))" >> $name
		echo "ATK=$(( (1 + RANDOM % $base) + (1 + RANDOM % $type) ))" >> $name
		echo "DEF=$(( (1 + RANDOM % $base) + (1 + RANDOM % $type) ))" >> $name
		echo "EXP=$(( (1 + RANDOM % $base) + (1 + RANDOM % $type) ))" >> $name
	done < codex
}