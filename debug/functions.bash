#!/bin/bash

makeplayer () {
	read -r $'Player Name?\n' pid
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

rm drawsnear.bash

sort -Ru lvl$level.bash | head -1 > enc.bash

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

sort -Ru lvl$level.bash | head -1 > enc.bash

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