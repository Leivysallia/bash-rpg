#!/bin/bash

log () {

	tee -a gamelog.bash

}

newline () {

echo $'\n'

}

render () {


source player.bash

export xvit=$vit

echo "$pid LV:$lvl"
echo "STA:$stamina DAY:$day"
echo "HP: $vit/$xvit"
echo "A:$atk D:$def"
echo "XP: $exp/$thresh"
echo $'1:Rest|2:Move|3:Save'

}

refresh () {

	cat player.bash > stats.bash
	cat /dev/null > player.bash
	source stats.bash

	echo pid=$pid >> player.bash
	echo lvl=$lvl >> player.bash
	echo vit=$vit >> player.bash
	echo def=$def >> player.bash
	echo atk=$atk >> player.bash
	echo exp=$exp >> player.bash

}

nat20 () {

	echo "Nat20!" |log
	echo "+1 to all stats." |log
	echo "Full Heal." |log
	export xvit=$(( xvit + 1 ))
	export vit=$xvit
	export def=$(( def + 1 ))
	export atk=$(( atk + 1 ))

	export natwenty=$(( natwenty + 1 ))

	refresh

}

makeplayer () {
origin=4
base=4
type=4

pid=DEBUG

##	read -r -p $'Player Name\?\n' pid
		echo "pid=$pid" >> player.bash
		echo "lvl=1" >> player.bash
		echo "vit=$(( (1 + RANDOM % $origin) + (1 + RANDOM % $base) + $type ))" >> player.bash
		echo "atk=$(( (1 + RANDOM % $origin) + (1 + RANDOM % $base) + $type ))" >> player.bash
		echo "def=$(( (1 + RANDOM % $origin) + (1 + RANDOM % $base) + $type ))" >> player.bash
		echo "exp=0" >> player.bash

		
		source player.bash

		refresh
}

cleanstart () {

clear

cat /dev/null > drawsnear.bash
cat /dev/null > enc.bash
cat /dev/null > seed.bash
cat /dev/null > player.bash

echo "slime 4 1 1
goblin 4 1 1
ghost 4 1 1" > level4.bash

echo "druin 6 4 4
scorpion 6 4 4
droll 6 4 4
slime 4 4 1
goblin 4 4 1
ghost 4 4 1" > level6.bash

echo "witch 10 6 6
skeleton 10 6 6
wolf 10 6 6
slime 4 4 4
goblin 4 4 4
ghost 4 4 4
druin 6 6 4
scorpion 6 6 4
droll 6 6 4" > level10.bash

echo "specter 12 10 10 
wraith 12 10 10
knight 12 10 10
druin 6 6 6
scorpion 6 6 6
droll 6 6 6
slime 4 4 4
goblin 4 4 4
ghost 4 4 4
witch 10 10 6
skeleton 10 10 6
wolf 10 10 6" > level12.bash

echo "wyrm 20 12 10
wyvern 20 12 12
dragon 20 20 20
specter 12 12 10 
wraith 12 12 10
knight 12 12 10
druin 10 6 6
scorpion 10 6 6
droll 10 6 6
slime 6 6 6
goblin 6 6 6
ghost 6 6 6
witch 10 10 10
skeleton 10 10 10
wolf 10 10 10" > level20.bash

echo "wyrm 20 12 10
wyvern 20 12 12
dragon 20 20 20
specter 12 12 12 
wraith 12 12 12
knight 12 12 12
druin 10 10 10
scorpion 10 10 10
droll 10 10 10
slime 10 10 10
goblin 10 10 10
ghost 10 10 10
witch 10 10 10
skeleton 10 10 10
wolf 10 10 10" > level30.bash

echo "demon 100 100 100" > level50.bash

makeplayer

if [[ -f save.bash ]]; then
	cat save.bash > player.bash
	source player.bash
	cat continue.bash > gamelog.bash
fi


}

levelcalc () {

	if [[ $lvl -le 50 ]]; then
		level=50
		d20 prng
		d20 prng2
		d10 prng3
		d20 mrng
		d20 mrng2
		d10 mrng3
	fi
	if [[ $lvl -le 30 ]]; then
		level=30
		d20 prng
	export	prng2=0
		d10 prng3
		d20 mrng
	export	mrng2=0
		d10 mrng3
	fi
	if [[ $lvl -le 20 ]]; then
		level=20
		d20 prng
	export	prng2=0
	export	prng3=0
		d20 mrng
	export	mrng2=0
	export	mrng3=0
	fi
	if [[ $lvl -le 12 ]]; then
		level=12
		d20 prng
	export	prng2=0
	export	prng3=0
		d20 mrng
	export	mrng2=0
	export	mrng3=0
	fi
	if [[ $lvl -le 10 ]]; then
		level=10
		d20 prng
	export	prng2=0
	export	prng3=0
		d20 mrng
	export	mrng2=0
	export	mrng3=0
	fi
	if [[ $lvl -le 6 ]]; then
		level=6
		d20 prng
	export	prng2=0
	export	prng3=0
		d20 mrng
	export	mrng2=0
	export	mrng3=0
	fi
	if [[ $lvl -le 4 ]]; then
		level=4
		d20 prng
	export	prng2=0
	export	prng3=0
		d20 mrng
	export	mrng2=0
	export	mrng3=0
	fi

}

heal () {

	levelcalc

	export heal=$(( 1 + RANDOM % $level ))

	vit=$(( vit + $heal ))
	if [[ $vit -gt $xvit ]]; then
	   export vit=$xvit
	fi

refresh

}

levelup () {

levelcalc

while [[ $exp -ge $thresh ]];do

if [[ $exp -ge $thresh ]]; then

	echo $"Level Up." |log
	echo "+d$level to all stats." |log
	echo "Full Heal." |log
	
	export lvl=$(( lvl + 1 ))
	export exp=$(( exp - thresh ))

	levelcalc

	export xvit=$(( (1 + RANDOM % $level) + $xvit ))
	export vit=$xvit
	export atk=$(( (1 + RANDOM % $level) + $atk ))
	export def=$(( (1 + RANDOM % $level) + $def ))

fi

done

export thresh=$(( ( 1 + RANDOM % $level ) * ( 1 + RANDOM % $level ) * ( 1 + RANDOM % $level ) ))

refresh

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

export	pinit=$(( ((atk + def) / $level) + (prng + prng2 + prng3) ))
export	minit=$(( ((ak + de) / $level) + (mrng + mrng2 + mrng3) ))

	if [[ $pinit -gt $minit ]]; then
		export init=1
	else
		export init=0
	fi

while true; do 

damagecalc

if [[ $init -eq 1 ]]; then
	export vi=$(( vi - pdam ))
	echo $"$pid does $pdam damage. $id has $vi remaining..." |log
	if [[ $vi -le 0 ]]; then
		export exp=$(( xp + exp ))

		heal

		echo "$id is dead. $pid gained $xp EXP. Healed $heal..." |log
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
	if [[ $vit -le 0 ]]; then
		echo "$pid is dead. :GAME OVER:" |log
		break
	fi
	export vi=$(( vi - pdam ))
	echo $"$pid does $pdam damage. $id has $vi remaining..." |log
	if [[ $vi -le 0 ]]; then
		export after=$(( 1 + RANDOM % $level ))
		export exp=$(( xp + exp ))

		heal

		echo "$id is dead. $pid gained $xp EXP. Healed $heal..." |log
		break

	fi
	
fi

done

cat drawsnear.bash >> gamelog.bash

levelup

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


	export	count=$(( count - 1 ))

	d20 mov

	if [[ $mov -eq 1 ]]; then
		echo $'Fateful Encounter...\n' |log

		fatenc
	fi
	if [[ $mov -eq 20 ]]; then
	
		nat20

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

export	count=$(( count + 1 ))

	
	d20 rest
	
	if [[ $rest -eq 1 ]]; then
		echo $'Encounter...\n' |log 
		enc
	fi

	if [[ $rest -ge 2 && $rest -le 19 ]]; then

		heal

	fi

	if [[ $rest -eq 20 ]]; then

		nat20

	fi

}

save () {

refresh

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

clean () {

clear

rm drawsnear.bash
rm enc.bash
rm seed.bash
rm player.bash
rm level*.bash
rm gamelog.bash

}