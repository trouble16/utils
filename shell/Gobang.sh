#!/bin/bash

PATH=${PATH}:/sbin:/usr/sbin:/usr/local/bin
export E33="[" Y_X=(20 30) Color _Color Pie=$(echo -e "  ")

function create_box() {
	typeset y x
	for ((y=10;y<=30;y++));do
		for ((x=10;x<=50;x+=2));do
			if (( x==10 )) || (( y==10 )) || (( x==50 )) || (( y==30 ));then
				echo -e "${E33}${y};${x}H${E33}43m  ${E33}49m\n"
			else
				if (( y%2==1 ));then 
					typeset C1=47 C2=49
				else
					typeset C1=49 C2=47
				fi
				if (( x%4==0 ));then 
					echo -e "${E33}${y};${x}H${E33}${C1}m${Pie}${E33}${C2}m${Pie:-  }${E33}49m";
					export box_${y}_${x}=${C1} box_${y}_$((x+2))=${C2}
				fi
			fi
		done
	done
	return 0
}
function _Display() {
	if (( $# == 3 ));then
		O_color=box_${Y_X[0]}_${Y_X[1]}
		echo -e "${E33}${Y_X[0]};${Y_X[1]}H${E33}${!O_color}m${Pie}${E33}49m"
		case "$3" in
		A)
			(( --Y_X[0]<11 )) && ((Y_X[0]++))
			;;
		B)
			(( ++Y_X[0]>29 )) && ((Y_X[0]--))
			;;
		C)
			(( (Y_X[1]+=2)>48 )) && ((Y_X[1]-=2))
			;;
		D)
			(( (Y_X[1]-=2)<12 )) && ((Y_X[1]+=2))
			;;
		esac
		echo -e "${E33}${Y_X[0]};${Y_X[1]}H${E33}46m${Pie}${E33}49m"
	fi
	return 0
}

function control() {
	while true;do
		read -s -n1 _T 2>/dev/null
		INPUT3=${INPUT2}
		INPUT2=${INPUT1}
		INPUT1=${_T}
		if [[ "${INPUT3}${INPUT2}${INPUT1}" =~ "${E33}"[ABCD] ]];then
			_Display ${Y_X[@]} ${INPUT1}
		elif [[ "[${_T}]" == "[]" ]];then
			O_color=box_${Y_X[0]}_${Y_X[1]}
			if [[ "${!O_color}" == 4[79] ]];then
				export box_${Y_X[0]}_${Y_X[1]}=42
				echo -e "${E33}${Y_X[0]};${Y_X[1]}H${E33}${!O_color}m${Pie:-  }${E33}49m"
				Check box_${Y_X[0]}_${Y_X[1]}
				if [ $? != 0 ];then Exit;fi
				AI
			fi
		elif [[ "${_T}" == [Qq] ]];then Exit;fi
	done
	return 0
}
function Check() {
	Color=${!1}
	for h in 0 1 3 2;do 
		j=0
		for i in -4 -3 -2 -1 0 1 2 3 4 ;do
			if (( h > 1 ));then
				_Color="box_$((Y_X[0]+i*$((2*h-5))))_$((Y_X[1]+2*i*$(((2*h-5)**2))))"
			else
				_Color="box_$((Y_X[0]+i*${h}))_$((Y_X[1]+2*i*$((! h))))"
			fi
			if [[ "${!_Color:-43}" == "${Color}" ]];then
				if (( ++j == 5 ));then
					if (( h > 1 ));then
						for ((k=i;k>i-5;k--));do
							echo -e "${E33}$((Y_X[0]+k*$((2*h-5))));$((Y_X[1]+2*k*$(((2*h-5)**2))))H${E33}${Color}m${E33}5m[]${E33}25m"
						done
					else
						for ((k=i;k>i-5;k--));do
							echo -e "${E33}$((Y_X[0]+k*${h}));$((Y_X[1]+2*k*$((! h))))H${E33}${Color}m${E33}5m[]${E33}25m"
						done
					fi
					return ${Color}
				fi
		else
			j=0
		fi
		done
	done
	return 0 
}

function weight5() {
	for Color in 41 42;do
		for h in 0 1 3 2;do 
			j=0
			for i in -4 -3 -2 -1 1 2 3 4 ;do
				if (( h > 1 ));then
					_Color="box_$((Y_X[0]+i*$((2*h-5))))_$((Y_X[1]+2*i*$(((2*h-5)**2))))"
				else
					_Color="box_$((Y_X[0]+i*${h}))_$((Y_X[1]+2*i*$((! h))))"
				fi
				if [[ "${!_Color:-43}" == "${Color}" ]];then
					if (( ++j == 4 ));then return ${Color};fi
				else
					j=0
				fi
			done
		done
	done
	return 0 
}

function weight4() {
	for Color in 41 42;do
		for h in 0 1 3 2;do 
			j=0;k=0
			for i in -3 -2 -1 1 2 3 ;do
				if (( h > 1 ));then
					_Color="box_$((Y_X[0]+i*$((2*h-5))))_$((Y_X[1]+2*i*$(((2*h-5)**2))))"
				else
					_Color="box_$((Y_X[0]+i*${h}))_$((Y_X[1]+2*i*$((! h))))"
				fi
				if [[ "${!_Color:-43}" == "${Color}" ]];then
					if (( ++j == 3 ));then
						if (( h > 1 ));then
							((i++))
							_Color="box_$((Y_X[0]+i*$((2*h-5))))_$((Y_X[1]+2*i*$(((2*h-5)**2))))"
							if [[ "${!_Color}" != 4[79] ]];then let Color+=2;fi
							((i-=5))
							_Color="box_$((Y_X[0]+i*$((2*h-5))))_$((Y_X[1]+2*i*$(((2*h-5)**2))))"
							if [[ "${!_Color}" != 4[79] ]];then let Color+=2;fi
						else
							((i++))
							_Color="box_$((Y_X[0]+i*${h}))_$((Y_X[1]+2*i*$((! h))))"
							if [[ "${!_Color}" != 4[79] ]];then let Color+=2;fi
							((i-=5))
							_Color="box_$((Y_X[0]+i*${h}))_$((Y_X[1]+2*i*$((! h))))"
							if [[ "${!_Color}" != 4[79] ]];then let Color+=2;fi
						fi
						[[ "${Color}" != 4[56] ]] && return ${Color}
					fi
				elif [[ "${!_Color:-43}" == 4[79] ]] && (( k == 0 ));then
					k=1
					continue
				else
					j=0;k=0
				fi
			done
		done
	done
	return 0 
}

function weight() {
	export Color=42 _SW
	(( Y_X[1] > 30 )) && _SW=$((24-Y_X[1]/2)) || _SW=$((Y_X[1]/2-6))
	(( Y_X[0] > 20 )) && _SW=$(((_SW+29-Y_X[0])/2)) || _SW=$(((_SW+Y_X[0]-11)/2))
	for h in 0 1 3 2;do 
		for i in -2 -1 1 2 ;do
			if (( h > 1 ));then
				_Color="box_$((Y_X[0]+i*$((2*h-5))))_$((Y_X[1]+2*i*$(((2*h-5)**2))))"
			else
				_Color="box_$((Y_X[0]+i*${h}))_$((Y_X[1]+2*i*$((! h))))"
			fi
			if [[ "${!_Color:-43}" == 42 ]];then
				((_SW+=1000))
			elif [[ "${!_Color:-43}" == 4[79] ]];then
				((_SW+=100))
			else
				((_SW-=300))
			fi
		done
	done
}
function AI() {
	export Old_Y_X=(0 0) Max=(1 0 0)
	Old_Y_X=(${Y_X[@]})
	for ((y=10;y<30;y++));do
		for ((x=10;x<50;x+=2));do
			_Color="box_${y}_${x}"
			if [[ "${!_Color}" == 4[79] ]];then
				Y_X=(${y} ${x})
				(( Y_X[1] > 30 )) && _W=$((24-Y_X[1]/2)) || _W=$((Y_X[1]/2-6))
				(( Y_X[0] > 20 )) && _W=$(((_W+29-Y_X[0])/2)) || _W=$(((_W+Y_X[0]-11)/2))
				if ! $(weight5);then
					if (( Max[0] < $((99999-$?*10)) ));then
						Max=("$((99999-$?*10))" "${Y_X[0]}" "${Y_X[1]}")
						continue
					fi
				elif ! $(weight4);then
					_B=$?
					if [[ ${_B} == 4[34] ]];then ((_B/=2));fi
					if (( Max[0] < $((50000+_W-${_B}*100)) ));then
						Max=("$((50000+_W-${_B}*100))" "${Y_X[0]}" "${Y_X[1]}")
						continue
					fi
				fi
			fi
		done
	done
	Y_X=(${Old_Y_X[@]})
	for h in 0 1 3 2;do
		for i in -1 1 ;do
			if (( h > 1 ));then
				_Color="box_$((Old_Y_X[0]+i*$((2*h-5))))_$((Old_Y_X[1]+2*i*$(((2*h-5)**2))))"
				Y_X=($((Old_Y_X[0]+i*$((2*h-5)))) $((Old_Y_X[1]+2*i*$(((2*h-5)**2)))))
			else
				_Color="box_$((Old_Y_X[0]+i*${h}))_$((Old_Y_X[1]+2*i*$((! h))))"
				Y_X=($((Old_Y_X[0]+i*${h})) $((Old_Y_X[1]+2*i*$((! h)))))
			fi
			if [[ "${!_Color:-43}" == 4[79] ]];then
				weight box_${Y_X[0]}_${Y_X[1]}
				if (( Max[1] == Y_X[0] )) && (( Max[2] == Y_X[1] ));then
					((Max[0]+=_SW))
				fi
				if (( Max[0] < _SW ));then
					Max=("${_SW}" "${Y_X[0]}" "${Y_X[1]}")
				fi
			fi
		done
	done
	Y_X=("${Max[1]}" "${Max[2]}")
	export box_${Y_X[0]}_${Y_X[1]}=41
	echo -e "${E33}${Y_X[0]};${Y_X[1]}H${E33}41m[]${E33}49m"
	Check box_${Y_X[0]}_${Y_X[1]}
	if [ $? != 0 ];then Exit;fi
	return 0
}

function Exit() {
	stty echo
	echo -e "${E33}35;0H${E33}49m${E33}39m${E33}?25h\n"
	exit 0
}

# main
trap 'Exit' 0 1 2 3 15 22 24
stty -echo
echo -e "${E33}?25l${E33}2J"
create_box
echo -e "${E33}${Y_X[0]};${Y_X[1]}H${E33}46m${Pie}${E33}49m"
control
exit 0
