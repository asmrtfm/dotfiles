while read line; do for x in {flac,mp3,mp4,ogg,opus,wav}; do [[ ${line} == *.${x} && ${line} != *[v/V][o/O][c/C][a/A][l/L]* && ${line} != *[l/L][i/I][p/P][e/E][n/N][s/S][k/K][y/Y] ]] || continue ; echo "${line}" ; done ; done < <(find -P ${HOME}/Music/Modern\ Day\ Babylon/ -depth -type f) | sort > ModernDayBabylon.pl
