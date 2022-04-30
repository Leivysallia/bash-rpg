#!/bin/bash

log () {

	tee -a gamelog.bash

}



newline () {

echo $'\n'

}

makeplayer () {
origin=4
base=4
type=4

pid=DEBUG

##	read -r -p $'Player Name\?\n' pid
		echo "pid=$pid" >> player.bash
		echo "lvl=0" >> player.bash
		echo "vit=$(( (1 + RANDOM % $origin) + (1 + RANDOM % $base) + $type ))" >> player.bash
		echo "atk=$(( (1 + RANDOM % $origin) + (1 + RANDOM % $base) + $type ))" >> player.bash
		echo "def=$(( (1 + RANDOM % $origin) + (1 + RANDOM % $base) + $type ))" >> player.bash
		echo "exp=0" >> player.bash

		
		source player.bash
		export xvit=$vit

		cat player.bash |log

}

cleanstart () {

clear

cat /dev/null > drawsnear.bash
cat /dev/null > enc.bash
cat /dev/null > seed.bash
cat /dev/null > player.bash

echo "druin 6 4 4
scorpion 6 4 4
droll 6 4 4" > level6.bash

echo "witch 10 6 6
skeleton 10 6 6
wolf 10 6 6" > level10.bash

echo "wyrm 20 12 10
wyvern 20 12 12
dragon 20 20 20" > level20.bash

echo "slime 4 1 1
goblin 4 1 1
ghost 4 1 1" > level4.bash

echo "specter 12 10 10 
wraith 12 10 10
knight 12 10 10" > level12.bash

makeplayer

if [[ -f save.bash ]]; then
	cat save.bash > player.bash
	source player.bash
	cat continue.bash > gamelog.bash
fi


}


levelcalc () {

	if [[ $lvl -le 20 ]]; then
		level=20
		d20 prng
		d20 mrng
	fi
	if [[ $lvl -le 12 ]]; then
		level=12
		d12 prng
		d12 mrng
	fi
	if [[ $lvl -le 10 ]]; then
		level=10
		d10 mrng
		d10 prng
	fi
	if [[ $lvl -le 6 ]]; then
		level=6
		d6 prng
		d6 mrng
	fi
	if [[ $lvl -le 4 ]]; then
		level=4
		d4 prng
		d4 mrng
	fi

}

damagecalc () {

levelcalc

export	patk=$(( atk + (1 + RANDOM % $level) ))
export	pdef=$(( def + (1 + RANDOM % $level) ))
export	matk=$(( ak + (1 + RANDOM % $level) ))
export	mdef=$(( de + (1 + RANDOM % $level) ))
export	pdam=$(( patk - mdef ))
export	mdam=$(( matk - pdef ))

	if [[ $pdam -le 0 ]]; then
		export pdam=$((1 + RANDOM % $level))
	fi
	if [[ $mdam -le 0 ]]; then
		export mdam=$((1 + RANDOM % $level))
	fi

}



battle () {
	
	levelcalc

source drawsnear.bash
source player.bash

echo $"$id draws near..." |log

export	pinit=$(( ((atk + def) / $level) + prng ))
export	minit=$(( ((ak + de) / $level) + mrng ))

	if [[ $pinit -gt $minit ]]; then
		export init=1
	else
		export init=0
	fi

while [[ $vit -gt 0 && $vi -gt 0 ]]; do 

damagecalc

if [[ $init -eq 1 ]]; then
	export vi=$(( vi - pdam ))
	echo $"$pid does $pdam damage. $id has $vi remaining..." |log
	if [[ $vi -le 0 ]]; then
		export after=$(( 1 + RANDOM % $level ))
		export vit=$(( $after  + vit ))
		export exp=$(( xp + exp ))
		if [[ $vit -gt $xvit ]]; then
			vit=$xvit
		fi
		echo "$id is dead. $pid gained $xp EXP. Healed $after" |log
		
		break

	fi
	export vit=$(( vit - mdam ))
	echo $"$id does $mdam damage. $pid has $vit remaining..." |log
	if [[ $vit -le 0 ]]; then
		echo "$pid is dead. :GAME OVER:" |log
		break
	fi
		else
	export vit=$(( vit - mdam ))
	echo $"$id does $mdam damage. $pid has $vit remaining..." |log
	if [[ $vi -le 0 ]]; then
		export after=$(( 1 + RANDOM % $level ))
		export vit=$(( $after  + vit ))
		export exp=$(( xp + exp ))
		if [[ $vit -gt $xvit ]]; then
			vit=$xvit
		fi
		echo "$id is dead. $pid gained $xp EXP. Healed $after" |log
		
		break

	fi
	export vi=$(( vi - pdam ))
	echo $"$pid does $pdam damage. $id has $vi remaining..." |log
	if [[ $vit -le 0 ]]; then
		echo "$pid is dead. :GAME OVER:" |log
		break
	fi
	
fi

done

cat drawsnear.bash >> gamelog.bash

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
		cat drawsnear.bash >> gamelog.bash
		battle

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
		cat drawsnear.bash | sed 's/[a-z]/\U&/g' >> gamelog.bash
		battle

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
		echo $'Fateful Encounter...\n' |log

		fatenc
	fi
	if [[ $mov -eq 20 ]]; then
		echo $'Nat20! +1 to all stats. Full Heal.' |log
		xvit=$(( xvit + 1 ))
		vit=$xvit
		def=$(( def + 1 ))
		atk=$(( atk + 1 ))
	fi
	if [[ $mov -ge 2 && $mov -le 10 ]]; then
		echo $'Encounter...\n' |log
		enc
	fi
	if [[ $mov -ge 11 && $mov -le 19 ]]; then
		echo $'Nothing Happens.' |log
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


save () {

	echo "pid=$pid" >> save.bash
	echo "lvl=$lvl" >> save.bash
	echo "xvit=$xvit" >> save.bash
	echo "vit=$vit" >> save.bash
	echo "atk=$atk" >> save.bash
	echo "def=$def" >> save.bash
	echo "exp=$exp" >> save.bash

	cat gamelog.bash > continue.bash

	exit

}