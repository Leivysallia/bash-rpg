#!/bin/bash

level=4

export day=1
export stamina=$(( 1 + RANDOM % $level ))

source player.bash

export xvit=$vit

echo "$pid LV:$lvl"
echo "STA:$stamina DAY:$day"
echo "HP: $vit/$xvit"
echo "A:$atk D:$def"
echo "XP: $exp/$thresh"
echo $'1:Rest|2:Move|3:Save'




echo "Stamina=$stamina"
echo "Day=$day"
echo $'1. Rest'
echo $'2. Move'
echo $'3. Save'