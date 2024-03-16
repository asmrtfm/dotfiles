while read line; do for x in {flac,mp3,mp4,ogg,opus,wav}; do [[ ${line} == *.${x} ]] || continue ; echo "${line}" ; done ; done < <(find -P ${HOME}/Music/Between\ The\ Buried\ And\ Me/ -depth -type f) | sort > BTBAM.pl

