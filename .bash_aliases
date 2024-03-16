# "preserve" inital ls cmd:
##alias l='ls'
# alias 1s='ls'
##alias la='l -A'
# alias la="$(which ls) -A"
##alias l1='l -A1'
# alias l1='la -1'
##alias ll='l -alF'
# alias ll='l1 -lF'
##alias lq='l -qQ'
# alias lq='l1 -qQ'
# alias lqa='lq -A1'
##alias lqa='lq -A1'
# alias lu='la -u'

# try to enable color support
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  # add some handy aliases
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
  alias rgrep='rgrep --color=auto'
  alias rg='rg --color=auto'
  # colored GCC warnings and errors
  export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
fi

# more ls aliases:
alias ls="ls --ignore='lost+found' -q"
alias lss='ls -S --si'
alias lsa='ls -A --hyperlink=auto --color=auto'
alias ls1='lsa -1'
alias lsq='ls1 -Q'
alias lsj='ls -A1qQmt'

#alias lst='lsa -t
# Add an "alert" alias for long running commands.  Use like so:
#sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias bashrc='for editr in subl micro nano vi ; do  [[ -x "$(realpath $(which $editr))" ]] || continue; $editr ~/.bashrc ; break ; done'
alias aliases='for each in ~/.*alias* ; do  for editr in subl micro nano vi ; do  [[ -x "$(realpath $(which $editr))" ]] || continue; $editr $each ; break ; done ; done'

abbreviate() {
	_Ab() { cat - | sed 's/ avenue/ ave/;s/ Avenue/ Ave/;s/ boulevard/ blvd/;s/ Boulevard/ Blvd/;s/ circle/ cl/;s/ Circle/ Cl/;s/ court/ ct/;s/ Court/ Ct/;s/ drive/ dr/;s/ Drive/ Dr/;s/ highway/ hwy/;s/ Highway/ Hwy/;s/ lane/ ln/;s/ Lane/ Ln/;s/ road/ rd/;s/ Road/ Rd/;s/ street/ st/;s/ Street/ St/;s/ parkway/ pkwy/;s/ Parkway/ Pkwy/;s/ place/ plc/;s/ Place/ Plc/;s/ wynde/ wnd/;s/ Wynde/ Wnd/' ; }
	[ -t 0 ] || cat - | _Ab
	for ((a=1;a<=$#;a++)); do
		case "${!a}" in
		\-[dDrR]|\-\-[dr][ie][rc][eu][cr][ts][oi][rv][ye]) ((++a)) && [[ ! -d "${!a}" ]] || $FUNCNAME "${!a}"/* ;;
		*) { [[ -f "${!a}" ]] && cat "${!a}" || echo "${!a}" ; } | _Ab
		esac
	done
}
alias abrv='abbreviate'

#url_encode() { sed -e "s/['\t']/%09/g;s/['\r']/%0d/g;s/[\€]/%80/g;s/[\‚]/%82/g;s/[\ƒ]/%83/g;s/[\„]/%84/g;s/[\…]/%85/g;s/[\†]/%86/g;s/[\‡]/%87/g;s/[\ˆ]/%88/g;s/[\‰]/%89/g;s/[\Š]/%8a/g;s/[\‹]/%8b/g;s/[\Œ]/%8c/g;s/[\Ž]/%8e/g;s/[\‘]/%91/g;s/[\’]/%92/g;s/[\“]/%93/g;s/[\”]/%94/g;s/[\•]/%95/g;s/[\–]/%96/g;s/[\—]/%97/g;s/[\˜]/%98/g;s/[\™]/%99/g;s/[\š]/%9a/g;s/[\›]/%9b/g;s/[\œ]/%9c/g;s/[\ž]/%9e/g;s/[\Ÿ]/%9f/g;s/[\¡]/%a1/g;s/[\¢]/%a2/g;s/[\£]/%a3/g;s/[\¤]/%a4/g;s/[\¥]/%a5/g;s/[\¦]/%a6/g;s/[\§]/%a7/g;s/[\¨]/%a8/g;s/[\©]/%a9/g;s/[\ª]/%aa/g;s/[\«]/%ab/g;s/[\¬]/%ac/g;s/[\®]/%ae/g;s/[\¯]/%af/g;s/[\°]/%b0/g;s/[\±]/%b1/g;s/[\²]/%b2/g;s/[\³]/%b3/g;s/[\´]/%b4/g;s/[\µ]/%b5/g;s/[\¶]/%b6/g;s/[\·]/%b7/g;s/[\¸]/%b8/g;s/[\¹]/%b9/g;s/[\º]/%ba/g;s/[\»]/%bb/g;s/[\¼]/%bc/g;s/[\½]/%bd/g;s/[\¾]/%be/g;s/[\¿]/%bf/g;s/[\À]/%c0/g;s/[\Á]/%c1/g;s/[\Â]/%c2/g;s/[\Ã]/%c3/g;s/[\Ä]/%c4/g;s/[\Å]/%c5/g;s/[\Æ]/%v6/g;s/[\Ç]/%c7/g;s/[\È]/%c8/g;s/[\É]/%c9/g;s/[\Ê]/%ca/g;s/[\Ë]/%cb/g;s/[\Ì]/%cc/g;s/[\Í]/%cd/g;s/[\Î]/%ce/g;s/[\Ï]/%cf/g;s/[\Ð]/%d0/g;s/[\Ñ]/%d1/g;s/[\Ò]/%d2/g;s/[\Ó]/%d3/g;s/[\Ô]/%d4/g;s/[\Õ]/%d5/g;s/[\Ö]/%d6/g;s/[\×]/%d7/g;s/[\Ø]/%d8/g;s/[\Ù]/%d9/g;s/[\Ú]/%da/g;s/[\Û]/%db/g;s/[\Ü]/%dc/g;s/[\Ý]/%dd/g;s/[\Þ]/%de/g;s/[\ß]/%df/g;s/[\à]/%e0/g;s/[\á]/%e1/g;s/[\â]/%e2/g;s/[\ã]/%e3/g;s/[\ä]/%e4/g;s/[\å]/%e5/g;s/[\æ]/%e6/g;s/[\ç]/%e7/g;s/[\è]/%e8/g;s/[\é]/%e9/g;s/[\ê]/%ea/g;s/[\ë]/%eb/g;s/[\ì]/%ec/g;s/[\í]/%ed/g;s/[\î]/%ee/g;s/[\ï]/%ef/g;s/[\ð]/%f0/g;s/[\ñ]/%f1/g;s/[\ò]/%f2/g;s/[\ó]/%f3/g;s/[\ô]/%f4/g;s/[\õ]/%f5/g;s/[\ö]/%f6/g;s/[\÷]/%f7/g;s/[\ø]/%f8/g;s/[\ù]/%f9/g;s/[\ú]/%fa/g;s/[\û]/%fb/g;s/[\ü]/%fc/g;s/[\ý]/%fd/g;s/[\þ]/%fe/g;s/[\ÿ]/%ff/g;s/[\$]/%24/g;s/[\&]/%26/g;s/[\+]/%2b/g;s/[\,]/%2c/g;s/[\:]/%3a/g;s/[\/]/%3b/g;s/[\=]/%3d/g;s/[\?]/%3f/g;s/[\@]/%40/g;s/[\ ]/%20/g;s/[\"]/%22/g;s/[\#]/%23/g;s/[\%]/%25/g;s/[\<]/%3C/g;s/[\>]/%3E/g;s/[\|]/%7C/g;s/[\{]/%7b/g;s/[\}]/%7d/g;s/[\^]/%5e/g;s/[\~]/%7e/g;s/[\[]/%5b/g;s/[\]]/%5d/g;s/[\`]/%60/g;s/[\\]/%5c/g;s/[\`]/%60/g" ; }
#_Url() {
#	_encode() {
#	local LC_ALL=C
#	for ((i=0;i< ${#1};i++)); do
#	    : "${1:i:1}"
#	    case "$_" in
#	    [a-zA-Z0-9.~_-]) printf '%s' "$_" ;;
#	    *) printf '%%%02X' "'$_"
#			esac
#	done
#	printf '\n'
#	}
#	_decode() {
#	    : "${1//+/ }"
#	    printf '%b\n' "${_//%/\\x}"
#	}
#	[ -t 0 ] || _${1} "$(cat -)"
#	(( $# < 2 )) || _${1} "${@:2}"
#}
#alias urlencode='_Url encode'
#alias urldecode='_Url decode'

# variadic-delemiter printer
Sprint() { local IFS=\  && printf '%s\n' "$([ -t 0 ] || cat -) ${*}" ; }
Qprint() { local IFS=\  && printf '%q\n' "$([ -t 0 ] || cat -) ${*}" ; }
Dprints() { local IFS=${1:-\ } && if [ ! -t 0 ]; then printf '%s\n' "$(cat -)${IFS}${*:2}" ; else printf '%s\n' "${*:2}" ; fi ; }
Dprintq() { local IFS=${1:-\ } && if [ ! -t 0 ]; then printf '%q\n' "$(cat -)${IFS}${*:2}" ; else printf '%q\n' "${*:2}" ; fi ; }

# floting-point printer
Fprint() { printf '%.3F\n' ${1} ; }; alias {f,F}print{,f}='Fprint'

#shove() { [[ -d "${1}" ]] || mkdir -p "${1}" ; cd "${1}" ; }
#alias {cdm,m{,k}cd}='shove'

###
## duplicate filename handler.  basically, it will mkdir -p the leading path(s), check if file exists, increment the ostensible counter if it does.
#   finally, it prints the full(real)Path that was constructed, but does not create the file.
#_poker() { [[ ! -f "${1}" ]] && { [[ ! -d "${1%\/*}" ]] && mkdir -p "${1%\/*}" ; echo "${1}" ; } || _poker "${1}.$(ls -A1 ${1}* | wcl | tr -d [[:space:]])" ; return $? ; }
#
## input/output handler for poke.
#   calls poke on each input line, and if successful it touches the output filePath.
#_poke() { for ((a=1;a<=$#;a++)); do touch "$(_poker ${!a})" || echo "FAILED to create file ${!a}" ; done ; return $? ; }
#
#alias {put,poke}='_poke'
###

#_rm() {
# local Flg
# local -i f=0
# local -a rarg item
# for ((a=1;a<=$#;a++)); do
#  if [[ "${!a}" == \-* ]]; then
#   case "${!a}" in
#   \-[a-eA-E-gz-G-Z]*f) rarg[${#rarg[@]}]="${!a:: -1}" ;;
#   \-f[a-eA-Eg-zG-Z]*) rarg[${#rarg[@]}]="-${!a#*f}" ;;
#   '-f'|'--force') ((++f)) ; continue ;;
#   \-[vV]|'--verbose') Flg=v ; continue ;;
#   *) [[ -e "${!a}" ]] && item[${#item[@]}]="${!a}" || rarg[${#rarg[@]}]="${!a}"
#   esac
#  else
#   item[${#item[@]}]="${!a}"
#  fi
# done
# if (( f == 3 )); then
#  for ((i=0;i<${#item[@]};i++)); do rm ${Flg:="--verbose"} ${rarg[@]} -f "${item[i]}" ; done
# else
#  for ((i=0;i<${#item[@]};i++)); do rm ${Flg:="--verbose"} ${rarg[@]} -i "${item[i]}" ; done
# fi
#}
#alias rm='_rm'
#WIPalias rm='echo "you want to: `rm {}`" ; read -p "[Y/n]: " decide ; [[ "$decide" != @([yY])?([eE][sS]) ]] || rm "{}"'

#_migrate() { if [[ ${EUID:-$UID} != 0 && "$USER" != "root" ]]; then sudo ${FUNCNAME} "$(realpath $1)" "$(realpath $2)" ; fi ; for that in "${1}"/* ; do if [[ ! -e "${2}/${that##*\/}" ]]; then [[ -d "${that}" ]] && cp -rpvi "${that}" "${2}"/ || cp -pnv "${that}" "${2}"/ ; else [[ ! -d "${2}/${that##*\/}" ]] || ${FUNCNAME} "${that}" "${2}/${that##*\/}" ; fi ; done ; }
#alias {cp{a,r},icp,Migrate}='_migrate'

## cleanly numbered `ls`
lsn() { local -i i=0 && for _ in $* ; do echo "$((++i)) ${_##*\/}" ; done ; }
export -f lsn

climb() { cd "$(basepath $1 "${2:-$PWD}")"; }
export -f climb

[[ ! -f ~/.aliases ]] || . ~/.aliases

