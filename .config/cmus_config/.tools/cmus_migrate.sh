#!/usr/bin/env bash

_Help() {
	_0() { echo "Script to migrate playlist path(s) to new user, etc..." && exit ${1}; }
	_1() { echo "Can not find cmus config directory..." && exit ${1}; }
	_2() { echo "Can not find cmus playlists directory..." && exit ${1}; }
	_3() { echo "Who the fuck are you?" && exit ${1}; }
	_${1} ${2:-${1}}
}

[[ ${1} != *[h/H] && ${1} != *[h/H][e/E][l/L][p/P] ]] || _Help 0

# [[ -d ${HOME}/.config/cmus ]] && CMUSCONFz=${HOME}/.config/cmus || _Help 1
[[ -d ${HOME}/.config/cmus/playlists ]] && PLAYLISTz=${HOME}/.config/cmus/playlists || _Help 2 1

if [[ -z ${USER} ]]; then
	if [[ -z ${HOME} ]]; then
		if [[ -d ~/ ]]; then
			HOME=~ && USER=${HOME##*\/}
		else
			_Help 3 2
		fi
	else
		USER=${HOME##*\/}
	fi
fi

#echo "${USER}"
#echo ""

_Migrate() {
	## Field 2 (/home, "home")
	_Check_1() { awk -F\/ '{print $2}' ${1} | awk '!a[$0]++'; }
	## Field_3 (Previous_Username)
	_Check_2() { awk -F\/ '{print $3}' ${1} | awk '!a[$0]++'; }
	## Field_4 (/home/user/Music, "Music")
	_Check_3() { awk -F\/ '{print $4}' ${1} | awk '!a[$0]++'; }
	[[ $(_Check_1 ${1}) != 'home' && $(_Check_3 ${1}) != [M/A]u[s/d]i[c/o] ]] || OldUser=$(_Check_2 ${1})
	[[ -z ${OldUser} ]] || OldUser=${OldUser//[!a-zA-Z0-9]/}
	[[ -z ${OldUser} ]] || sed -i "s/${OldUser}/${USER}/g" ${1}
	#[[ -z ${OldUser} ]] || echo "${OldUser}"
}

for List in ${PLAYLISTz}/* ; do
	# [[ ! -f ${List} ]] || PL[${#PL[@]}]="${List}"
	[[ ! -f ${List} ]] || _Migrate "${List[@]}"
done
