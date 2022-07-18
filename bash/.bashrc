export EDITOR="vim"
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# if not running interactively, don't do anything
[ -z "$PS1" ] && return

# colorize output
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias diff='diff --color=auto'

# enable bash completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# copy previous commands: Ctrl+] (or xc)
bind '"\C-]":"\C-e\C-u xclip -selection clipboard <<"EOF"\n\C-y\nEOF\n"' 2>/dev/null
alias xc='history 2 | cut -c 8- | head -n 1 | xclip -selection clipboard'

