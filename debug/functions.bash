#!/bin/bash

makeplayer () {

		echo "PID=Player" >> player
		echo "LVL=0" >> player
		echo "VIT=$(( (1 + RANDOM % 6) + (1 + RANDOM % 4) ))" >> player
		echo "ATK=$(( (1 + RANDOM % 6) + (1 + RANDOM % 4) ))" >> player
		echo "DEF=$(( (1 + RANDOM % 6) + (1 + RANDOM % 4) ))" >> player
		echo "EXP=0" >> player
		export player
		source player
}

levelcalc () {

	if [[ $LVL -le 20 ]]; then
		level=20
	fi
	if [[ $LVL -le 12 ]]; then
		level=12
	fi
	if [[ $LVL -le 10 ]]; then
		level=10
	fi
	if [[ $LVL -le 6 ]]; then
		level=6
	fi
	if [[ $LVL -le 4 ]]; then
		level=4
	fi

}


cleanstart () {

touch Dragon Droll Druin Ghost Goblin Knight Player Scorpion Skeleton Slime Specter Witch Wolf Wraith Wyrm Wyvern mc save vars
rm Dragon Droll Druin Ghost Goblin Knight Player Scorpion Skeleton Slime Specter Witch Wolf Wraith Wyrm Wyvern mc save vars

}

enc () {

levelcalc

sort -Ru lvl$level.bash | head -1 > enc.bash

	while read -r name origin base type; do
		echo "ID=$name" >> $name
		echo "VI=$(( (1 + RANDOM % $origin) + (1 + RANDOM % $base) + $type ))" >> $name
		echo "AK=$(( (1 + RANDOM % $origin) + (1 + RANDOM % $base) + $type ))" >> $name
		echo "DE=$(( (1 + RANDOM % $origin) + (1 + RANDOM % $base) + $type ))" >> $name
		echo "XP=$(( (1 + RANDOM % $origin) + (1 + RANDOM % $base) + $type ))" >> $name
	done < enc.bash
		export $name
		source $name

}

d20 () {

export $1=$((1 + RANDOM % 20))

}

d12 () {

export $1=$((1 + RANDOM % 12))

}

d10 () {

export $1=$((1 + RANDOM % 10))

}

d6 () {

export $1=$((1 + RANDOM % 6))
	
}

d4 () {

export $1=$((1 + RANDOM % 4))

}
