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

refresh () {

	cat /dev/null > player.bash

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

	refresh

}
