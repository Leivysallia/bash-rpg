#!/bin/bash


newline () {

echo $'\n'

}

cleanstart () {

if [[ -f player.bash ]]; then
   cat player.bash > save.bash
fi

cat /dev/null > drawsnear.bash
cat /dev/null > enc.bash
cat /dev/null > seed.bash
cat /dev/null > player.bash

echo "druin 6 4 4
scorpion 6 4 4
droll 6 4 4" > levelsix.bash

echo "witch 10 6 6
skeleton 10 6 6
wolf 10 6 6" > levelten.bash

echo "wyrm 20 12 10
wyvern 20 12 12
dragon 20 20 20" > leveltwenty.bash

echo "slime 4 1 1
goblin 4 1 1
ghost 4 1 1" > levelfour.bash

echo "specter 12 10 10 
wraith 12 10 10
knight 12 10 10" > leveltwelve.bash

}

makeplayer () {
	read -r -p $'Player Name\?\n' pid
		echo "pid=$pid" >> player.bash
		echo "lvl=0" >> player.bash
		echo "vit=$(( (1 + RANDOM % 6) + (1 + RANDOM % 4) ))" >> player.bash
		echo "xvit=$vit"
		echo "atk=$(( (1 + RANDOM % 6) + (1 + RANDOM % 4) ))" >> player.bash
		echo "def=$(( (1 + RANDOM % 6) + (1 + RANDOM % 4) ))" >> player.bash
		echo "exp=0" >> player.bash

		source player.bash
}

levelcalc () {

	if [[ $lvl -le 20 ]]; then
		level=twenty
	fi
	if [[ $lvl -le 12 ]]; then
		level=twelve
	fi
	if [[ $lvl -le 10 ]]; then
		level=ten
	fi
	if [[ $lvl -le 6 ]]; then
		level=six
	fi
	if [[ $lvl -le 4 ]]; then
		level=four
	fi

}

enc () {

levelcalc

rm drawsnear.bash

sort -Ru level$level.bash | head -1 > enc.bash

	while read -r name origin base type; do
		echo "id=$name" >> drawsnear.bash
		echo "vi=$(( (1 + RANDOM % $origin) + (1 + RANDOM % $base) + $type ))" >> drawsnear.bash
		echo "ak=$(( (1 + RANDOM % $origin) + (1 + RANDOM % $base) + $type ))" >> drawsnear.bash
		echo "de=$(( (1 + RANDOM % $origin) + (1 + RANDOM % $base) + $type ))" >> drawsnear.bash
		echo "xp=$(( (1 + RANDOM % $origin) + (1 + RANDOM % $base) + $type ))" >> drawsnear.bash
	done < enc.bash
		
		source drawsnear.bash

}

fatenc () {

levelcalc

rm drawsnear.bash

sort -Ru level$level.bash | head -1 > enc.bash

	while read -r name origin base type; do
		echo "id=$name" >> drawsnear.bash
		echo "vi=$(( $origin + $base + $type ))" >> drawsnear.bash
		echo "ak=$(( $origin + $base + $type ))" >> drawsnear.bash
		echo "de=$(( $origin + $base + $type ))" >> drawsnear.bash
		echo "xp=$(( $origin + $base + $type ))" >> drawsnear.bash
	done < enc.bash
		
		source drawsnear.bash

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

move () {

	d20 mov
##	echo $mov

	if [[ $mov -eq 1 ]]; then
		fatenc
		echo $'Fateful Encounter...\n'
		cat drawsnear.bash | sed 's/[a-z]/\U&/g'
	fi
	if [[ $mov -eq 20 ]]; then
		echo $'Nat20! +1 to all stats. Full Heal.' 
		xvit=$(( xvit + 1 ))
		vit=$xvit
		def=$(( def + 1 ))
		atk=$(( atk + 1 ))
	fi
	if [[ $mov -ge 2 && $mov -le 10 ]]; then
		enc
		echo $'Encounter...\n'
		cat drawsnear.bash
	fi
	if [[ $mov -ge 11 && $mov -le 19 ]]; then
		echo $'Nothing Happens.'
	fi
	
}

rest () {

	d20 rest

	if [[ $rest -eq 1 ]]; then
		enc
		echo $'Encounter...\n'
		cat drawsnear.bash
	fi
	if [[ $rest -eq 2 ]]; then
		d4 heal
		$vit=$(( heal + vit ))
		if [[ $vit -gt $xvit ]]; then
			vit=$xvit
		fi
	fi
	if [[ $rest -eq 3 ]]; then
		d6 heal
		$vit=$(( heal + vit ))
		if [[ $vit -gt $xvit ]]; then
			vit=$xvit
		fi
	fi
	if [[ $rest -eq 4 ]]; then
		d10 heal
		$vit=$(( heal + vit ))
		if [[ $vit -gt $xvit ]]; then
			vit=$xvit
		fi
	fi
	if [[ $rest -eq 5 ]]; then
		d12 heal
		$vit=$(( heal + vit ))
		if [[ $vit -gt $xvit ]]; then
			vit=$xvit
		fi
	fi
	if [[ $rest -eq 6 ]]; then
		d6 heal
		$vit=$(( heal + vit ))
		if [[ $vit -gt $xvit ]]; then
			vit=$xvit
		fi
	fi
	if [[ $rest -eq 7 ]]; then
		d10 heal
		$vit=$(( heal + vit ))
		if [[ $vit -gt $xvit ]]; then
			vit=$xvit
		fi
	fi
	if [[ $rest -eq 8 ]]; then
		d12 heal
		$vit=$(( heal + vit ))
		if [[ $vit -gt $xvit ]]; then
			vit=$xvit
		fi
	fi	
	if [[ $rest -eq 9 ]]; then
		d6 heal
		$vit=$(( heal + vit ))
		if [[ $vit -gt $xvit ]]; then
			vit=$xvit
		fi
	fi
	if [[ $rest -eq 10 ]]; then
		d20 heal
		$vit=$(( heal + vit ))
		if [[ $vit -gt $xvit ]]; then
			vit=$xvit
		fi
	fi	
	if [[ $rest -eq 11 ]]; then
		d10 heal
		$vit=$(( heal + vit ))
		if [[ $vit -gt $xvit ]]; then
			vit=$xvit
		fi
	fi
	if [[ $rest -eq 12 ]]; then
		d12 heal
		$vit=$(( heal + vit ))
		if [[ $vit -gt $xvit ]]; then
			vit=$xvit
		fi
	fi
	if [[ $rest -eq 13 ]]; then
		d6 heal
		$vit=$(( heal + vit ))
		if [[ $vit -gt $xvit ]]; then
			vit=$xvit
		fi
	fi
	if [[ $rest -eq 14 ]]; then
		d10 heal
		$vit=$(( heal + vit ))
		if [[ $vit -gt $xvit ]]; then
			vit=$xvit
		fi
	fi
	if [[ $rest -eq 15 ]]; then
		d12 heal
		$vit=$(( heal + vit ))
		if [[ $vit -gt $xvit ]]; then
			vit=$xvit
		fi
	fi
	if [[ $rest -eq 16 ]]; then
		d6 heal
		$vit=$(( heal + vit ))
		if [[ $vit -gt $xvit ]]; then
			vit=$xvit
		fi
	fi
	if [[ $rest -eq 17 ]]; then
		d10 heal
		$vit=$(( heal + vit ))
		if [[ $vit -gt $xvit ]]; then
			vit=$xvit
		fi
	fi
	if [[ $rest -eq 18 ]]; then
		d12 heal
		$vit=$(( heal + vit ))
		if [[ $vit -gt $xvit ]]; then
			vit=$xvit
		fi
	fi
	if [[ $rest -eq 19 ]]; then
		d4 heal
		$vit=$(( heal + vit ))
		if [[ $vit -gt $xvit ]]; then
			vit=$xvit
		fi
	fi
	if [[ $rest -eq 20 ]]; then
		echo $'Nat20! +1 to all stats. Full Heal.' 
		xvit=$(( xvit + 1 ))
		vit=$xvit
		def=$(( def + 1 ))
		atk=$(( atk + 1 ))
	fi

}