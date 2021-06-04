# Zsh history
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY 2>/dev/null # _all_ zsh sessions share the same history files
setopt HIST_IGNORE_ALL_DUPS 2>/dev/null   # ignores duplications
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000

# Enable 256 color capabilities for appropriate terminals
# from http://fedoraproject.org/wiki/Features/256_Color_Terminals
# Set this variable in your local shell config if you want remote
# xterms connecting to this system, to be sent 256 colors.
# This can be done in /etc/csh.cshrc, or in an earlier profile.d script.
#   SEND_256_COLORS_TO_REMOTE=1

# Terminals with any of the following set, support 256 colors (and are local)
local256="$VTE_VERSION$COLORTERM$XTERM_VERSION$ROXTERM_ID$KONSOLE_DBUS_SESSION"

if [ -n "$local256" ] || [ -n "$SEND_256_COLORS_TO_REMOTE" ]; then

  case "$TERM" in
    'xterm') TERM=xterm-256color;;
    'screen') TERM=screen-256color;;
    'Eterm') TERM=Eterm-256color;;
  esac
  export TERM

  if [ -n "$TERMCAP" ] && [ "$TERM" = "screen-256color" ]; then
    TERMCAP=$(echo "$TERMCAP" | sed -e 's/Co#8/Co#256/g')
    export TERMCAP
  fi
fi

unset local256

# dircolor solarized theme
# eval `dircolors $HOME/.solarized/dircolors.ansi-light`

MON_SYS=`uname -s`
# Gestion du ls : couleur + touche pas aux accents
alias ls='ls --classify --tabsize=0 --literal --color=auto --show-control-chars --human-readable'

# Gestion du grep : couleur
alias grep='grep --color=auto'

# Raccourcis pour 'ls'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
# merci la DSI
alias sl=ls
alias gti=git
alias vi=vim
alias sudo="sudo "
alias sd="shutdown now"
alias rb="reboot now"

# Prompt qui detecte les dépôts et les environnements virtuels de python
function git_ref {
# la première partie nous donne le HEAD actuel si on y est; de la forme refs/heads/toto
# la seconde un nom si on n'est pas dans HEAD
  rf=$(git symbolic-ref -q HEAD || git name-rev --name-only --always HEAD)
  # on enlève refs/heads/ pour ne récupérer que le nom de la branche
  rf=${rf#refs/heads/}
  echo $rf
}

function prompt_char {
   git branch >&/dev/null && echo -n '[git<'&& echo -n $(git_ref) && echo '>]' && return
}

function virtualenv_info {
   [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`')'
}

#precmd_functions+='prompt_char'
#function preexec() {
function precmd() {
    PROMPT="%B%F{green}%m%F{yellow}$(virtualenv_info)$(prompt_char)%f 👾%b "
}

# Change le titre de la fenêtre
autoload -Uz add-zsh-hook
function xterm_title_precmd () {
	print -Pn -- '\e]2;%n@%m %~\a'
	[[ "$TERM" == 'screen'* ]] && print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-}\e\\'
}
add-zsh-hook -Uz precmd xterm_title_precmd

# Completion
autoload -Uz compinit
compinit

# Afficher le dir à droite 
RPROMPT="%F{yellow}%~%f"

alias PDF=evince
alias IMG=eog
