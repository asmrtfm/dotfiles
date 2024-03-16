#!/bin/bash
_Usage() {
	_Help() { echo "Usage: $(basename $0) [-o, --output] [OUTPUT] ['ARTIST NAME' or 'QUERY STRING']"; }
	_1() { _Help && exit 1; }
	_${1}
}
[[ $1 == \-[o/O] || $1 == \-\-[o/O][u/U][t/T][p/P][u/U][t/T] ]] && Output="$2" || _Usage 1
MUSIC="$(basepath ${HOME}/Music)"
#Query="${@:3}"
# _MainFunct() {
# Item=$(printf '%q' "$@")
# echo "$MUSIC/${Item}"
while read line; do
	for x in {flac,mp3,mp4,ogg,opus,wav}; do
		[[ ${line} == *.${x} ]] || continue
		echo "${line/${MUSIC}/\/home\/${USER}\/Music}"
	done
done < <(find -P "${MUSIC}/${@:3}" -depth -type f) | sort >> ${HOME}/.config/cmus/playlists/${Output}.pl

# _MainFunct "${Query}"

