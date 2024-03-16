# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

## If not running interactively, don't do anything
#case $- in  *i*) ;;  *) return ; esac
[[ $- == *i* ]] || return

## Append to the history file, don't overwrite it
shopt -s histappend

## Don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth


## For setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=3072
HISTFILESIZE=9216

## Check the window size after each command and, if necessary,
#   update the values of LINES and COLUMNS.
shopt -s checkwinsize

## On to enable pcre2 regex globally (for exmaple, within `case` statements)
shopt -s extglob

## If set, the pattern "**" used in a pathname expansion context will
#   match all files and zero or more directories and subdirectories.
#shopt -s globstar

## Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

## Set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then debian_chroot=$(cat /etc/debian_chroot) ; fi

## Enable programmable completion features
#   (you don't need to enable this, if it's already enabled
#    in /etc/bash.bashrc and /etc/profile sources /etc/bash.bashrc).
if ! shopt -oq posix; then if [ -f /usr/share/bash-completion/bash_completion ]; then . /usr/share/bash-completion/bash_completion ; elif [ -f /etc/bash_completion ]; then . /etc/bash_completion ; fi ; fi

### PROMPT Customizations
if [[ -f ~/.promptrc ]]; then source ~/.promptrc
else #default sequence:
  ## set a fancy prompt (non-color, unless we know we "want" color)
  case "$TERM" in  xterm-color|*-256color) color_prompt=yes ;;  esac
  ## uncomment for a colored prompt, if the terminal has the capability; turned
  # off by default to not distract the user: the focus in a terminal window
  # should be on the output of commands, not on the prompt
  #force_color_prompt=yes
  if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
      # We have color support; assume it's compliant with Ecma-48
      # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
      # a case would tend to support setf rather than setaf.)
      color_prompt=yes
    else color_prompt=
    fi
  fi
fi
###
if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
else
  if [ "$color_prompt" = yes ]; then PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
  else PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ ' ; fi
  unset color_prompt force_color_prompt
  ## If this is an xterm set the title to user@host:dir
  case "$TERM" in  xterm*|rxvt*) PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1" ;;  esac
fi
###

### Alias definitions.
[[ ! -f ~/.bash_aliases ]] || . ~/.bash_aliases

### Additional PATH inclusions.
[[ ! -f ~/.pathrc ]] || . ~/.pathrc

### [Lineage] Build Environment Settings:
#export USE_CCACHE=1
#export CCACHE_EXEC=/usr/bin/ccache
#export CCACHE_DIR=/media/storage/.ccache
# for building lineage-{15.1,16.0}
#export ANDROID_JACK_VM_ARGS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4G"
#

### Literally don't even remember what these are for.
#   pretty sure it had something to do with window decorations on flatpacks...
#   ...or maybe keybinds... or both.
#export GTK_IM_MODULE=ibus
#export XMODIFIERS=@im=ibus
#export QT_MODULE=ibus

### Making tab completion of ./filenames work for op.
# first, noticed that there is an existing file:'/usr/share/bash-completion/completions/op'
#         ...despite no installed program `op` (other than ours, in $HOME/bin/op).
#            moved it to '/usr/share/bash-completion/completions/.op'
#      only then, did adding the following line seem to work:
#complete -r op 2>/dev/null
# which disables `bash_completion` for `op` and uses bash's native filename completion instead.

### instead of pulling in our other.rc(s) by default:
alias otherz='[[ ! -f ~/.otherrc ]] || source ~/.otherrc'

## Fix for Tilix
[ ! $TILIX_ID ] || source /etc/profile.d/vte.sh

### Use most instead of [more||less] as system PAGER.
export PAGER="most"

## DetaSpace
#[[ ! -d "$HOME/.detaspace/bin" ]] || export PATH="/home/me/.detaspace/bin:$PATH"
#[[ ! -f "$HOME/.spacerc" ]] || . "$HOME/.spacerc"

## Reminders
{ for _ in ~/{,*/}*.reminder ; do [[ ! -f $_ ]] || notify-send  $(< $_) ; done ; } 2>/dev/null

export TODAY=$(date +'%Y%m%d')

[[ ! -f $HOME/.path_aliases ]] || . $HOME/.path_aliases

## Cope with Cursor's rapid development cycle which constantly breaks the launcher file on linux.
Current=$(lsc ~/.local/bin/cursor* | tail -n1 | cut -d\  -f2 2>/dev/null)
Launcher=$(find ~/.local/share/applications/ -type f -iname "*cursor*.desktop" 2>/dev/null)
if [[ -e "$Current" && -e "$Launcher" ]]; then : "$(grep 'X-AppInstall-Package=' "$Launcher" | cut -d\= -f2)"; sed -i "s|${_}|${Current##*\/}|g" "$Launcher"; fi
export TESSDATA_PREFIX=$HOME/.local/share/tessdata

