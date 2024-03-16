#!/bin/bash
declare -g Plist
if [[ -f ${2} && ${2} == *.xml ]]; then
	Plist="${2}"
else
	while read line; do
		if [[ -d ${line} ]]; then
			for x in ${line}/*.xml; do
				if [[ -f ${x} && ${x} == *playlist*xml ]]; then
					Plist="${x}"
				elif [[ -f ${x} && ${x} == *db*xml ]]; then
					RbDb="${x}"
				fi
			done
		fi
	done < <(find -P ${HOME} -type d -iname "*.rhythmbox*")
fi
[[ -d ${HOME}/.config/cmus ]] && CMUS_DIR=${HOME}/.config/cmus || CMUS_DIR="${PWD}"

_urlDecode() {
	# Usage: urldecode "string"
	: "${1//+/ }"
	printf '%b\n' "${_//%/\\x}"
}
_genPlaylist() {
	while read line; do
		[[ ${line} == *\<location\>* ]] || continue
		_urlDecode "$(echo "${line##*'file://'}" | sed 's/<\/location>//')"
	done < <(awk "/^  <playlist name\=\"${2}\" /{p=1;print;next} p&&/^  <\/playlist>/{p=0};p" "${Plist:-${1}}")
}

[[ $1 == \-* ]] || exit 3
case ${1//\-/} in
[p/P]|[p/P][l/L][a/A][y/Y][l/L][i/I][s/S][t/T])
	for a in "${@:3}"; do
		_genPlaylist "${Plist:-${2}}" "${a}" | tee -a ${CMUS_DIR}/${a//[[:space:]]/}.pl
	done
	;;
[a/A]|[c/C]|[a/A][l/L][l/L]|[c/C][o/O][n/N][v/V][e/E][r/R][t/T])
	for List in $(awk -F\" '/^  <playlist name\=\"/ {print $2}' "${Plist:-${2}}"); do
		# Playlist[${#Playlist[@]}]="${List}"
		_genPlaylist "${Plist:-${2}}" "${List}" | tee -a ${CMUS_DIR}/.Playlists/${List//[[:space:]]/}.pl
	done
	;;
[h/H]|[h/H][e/E][l/L][p/P]) echo "Heyelp" && exit 1 ;;
*) exit 3
esac
