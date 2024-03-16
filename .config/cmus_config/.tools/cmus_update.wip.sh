#!/usr/bin/env bash

### CMUS UPDATE/RECOMPILE SCRIPT
##   pull from git repo and/or (re)compile (with selectable flags)
#

## CONFIG_CUE=y CONFIG_FFMPEG=y CONFIG_FLAC=y CONFIG_MAD=y CONFIG_MP4=y CONFIG_OPUS=y CONFIG_PULSE=y CONFIG_VORBIS=y CONFIG_WAV=y

AllOpts=(
	CONFIG_AAC
	CONFIG_ALSA
	CONFIG_AO
	CONFIG_ARTS
	CONFIG_CDIO
	CONFIG_COREAUDIO
	CONFIG_CUE
	CONFIG_FFMPEG
	CONFIG_FLAC
	CONFIG_JACK
	CONFIG_MAD
	CONFIG_MIKMOD
	CONFIG_MODPLUG
	CONFIG_MP4
	CONFIG_MPC
	CONFIG_MPRIS
	CONFIG_OPUS
	CONFIG_OSS
	CONFIG_PULSE
	CONFIG_ROAR
	CONFIG_SAMPLERATE
	CONFIG_SNDIO
	CONFIG_SUN
	CONFIG_VORBIS
	CONFIG_VTX
	CONFIG_WAV
	CONFIG_WAVEOUT
	CONFIG_WAVPACK
	CONFIG_BASS
)
DefOpts=(
	CONFIG_CUE
	CONFIG_FFMPEG
	CONFIG_FLAC
	CONFIG_MAD
	CONFIG_MP4
	CONFIG_OPUS
	CONFIG_PULSE
	CONFIG_VORBIS
	CONFIG_WAV
)
#for d in ${DefOpts[@]}; do
#	Y[${#Y[@]}]="${d}"
#done

_AddFlags() {
	[[ -z ${Q} ]] || unset Q[*]
	while :; do
		tput clear
                if [[ -n ${Q} ]]; then
			[[ -z ${Show} ]] || unset Show[*] 2>/dev/null
                        for ((a=0;a<${#AllOpts[@]};a++)); do
				[[ -z ${Hit} ]] || unset Hit
                                for q in ${Q[@]}; do
                                        [[ ${AllOpts[a]} != ${q} ]] || Hit="${q}"
                                done
                                [[ -n ${Hit} && ${Hit} == ${AllOpts[a]} ]] || Show[${#Show[@]}]="${AllOpts[a]}"
                        done
                        echo "${Q[@]}"
		else
			Show=${AllOpts[@]}
                fi
                echo "Add Flag..."
		select Add in Back Clear Save ${Show[@]}; do
			case ${Add} in
			'Back') return 0 ;;
			'Save')
				for q in ${Q[@]}; do
					# Check if already in Y before adding to Y
					# hit empty then add to Y
					if [[ -n ${Y} ]]; then
						for y in ${Y[@]}; do
							[[ -z ${Hit} ]] || unset Hit
							[[ ${q} != ${y} ]] || Hit="${y}"
						done
						[[ -n ${Hit} && ${Hit} == ${q} ]] || Y[${#Y[@]}]="${q}"
					else
						Y[${#Y[@]}]="${q}"
					fi
				done
				;;
			'Clear') unset Q[*] ;;
			*) Q[${Q[@]}]="${Add}" ;;
			?) echo "Invalid selection"
			esac
			break
		done
	done
}

_RemoveFlags() {
	[[ -z ${Q} ]] || unset Q[*]
	while :; do
		tput clear
		if [[ -n ${Q} ]]; then
			for ((y=0;y<${#Y[@]};y++)); do
				[[ -z ${Hit} ]] || unset Hit
				for q in ${Q[@]}; do
					[[ ${Y[y]} != ${q} ]] || Hit="${q}"
				done
				[[ -n ${Hit} && ${Hit} == ${Y[y]} ]] || Show[${#Show[@]}]="${Y[y]}"
			done
			echo "${Q[@]}"
		else
			Show=${Y[@]}
		fi
		echo "Remove..."
		select Rem in Back Clear Save ${Y[@]}; do
			case ${Rem} in
			'Back') return 0 ;;
			'Save')
				for q in ${Q[@]}; do
					Y[${#Y[@]}]="${q}"
				done
				# return 0
				;;
			'Clear') unset Q[*] ;;
			*) Q[${#Q[@]}]="${Rem}" ;;
			?) echo "Invalid selection"
			esac
			break
		done
		[[ ${Rem} == 'Save' ]] && return 0 || unset Rem
	done
}

while :; do
	tput clear && echo "Active Compilation Flags:"
	if [[ -n ${Y} ]]; then
		for i in ${Y[@]}; do
			echo "${i} = y"
		done
	fi
	echo "Change Flags?"
	select Action in 'Start Compiling' 'Add Flags' 'Remove Flags' 'Clear All' 'Defaults'; do
		case ${Action} in
		'Add Flags') _AddFlags ;;
		'Remove Flags') _RemoveFlags ;;
		'Clear All') unset Q[*] Y[*] 2>/dev/null ;;
		'Defaults')
			echo "Set flags to Defaults?"
			echo "  (Defaults are set based on ~/.config/cmus/.tools/Default_Flags.list)"
			echo "  This will overide any previously made changes"
			read -p "Set Defaults?   [y/N]: " DEF
			if [[ ${DEF} == [y/Y] ]]; then
				[[ -z ${Y} ]] || unset Y[*] 2>/dev/null
				for d in ${DefOpts[@]}; do
					Y[${#Y[@]}]="${d}"
				done
			fi
			;;
		'Start Compiling')
			[[ ${PWD} == ~/Source/cmus ]] || cd ~/Source/cmus
			echo "Configuring..." && sleep 0.5
			[[ -n ${Y} ]] && ./configure "${Y[@]}" || ./configure
			echo "If there were no errors, we should be ready to compile"
			read -p "Proceed?   [y/N]: " PROCEED
			if [[ ${PROCEED} == [y/Y] ]]; then
				make clean
				make && sudo make install
				exit ${?}
			else
				clear
				read -p "Exit?   [y/N]: " Exit
				[[ ${Exit} != [y/Y] ]] || exit 0
			fi
			;;
		?) echo "Invalid Selection"
		esac
		break
	done
done
