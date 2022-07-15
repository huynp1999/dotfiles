packages=$(curl https://raw.githubusercontent.com/huynp1999/dotfiles/master/packages)
common=$(echo $packages | tr '.' '\n' | sed -n '1p' | cut -d' ' -f2-)
deb=$(echo $packages | tr '.' '\n' | sed -n '2p' | cut -d' ' -f2-)
rpm=$(echo $packages | tr '.' '\n' | sed -n '1p' | cut -d' ' -f2-)
if [ -n "$(which yum)" ]
then
	yum install $packages -y
else
	apt update; apt install $packages -y
fi

# setup vim
rm -rf /usr/bin/vi
ln -s /usr/bin/vim /usr/bin/vi
cp -r ./.vim* ~

#setup bashrc
iphostname=$(hostname -I)+$(hostname)
if grep -Fxq "$iphostname" /etc/hosts
then
	echo `hostname -I` `hostname` >> /etc/hosts
fi

cat << EOF >> ~/.bashrc
# enable bash completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
# copy previous commands: 1. Ctrl+] 2. xc
bind '"\C-]":"\C-e\C-u xclip -selection clipboard <<"EOF"\n\C-y\nEOF\n"'
alias xc='history 2 | cut -c 8- | head -n 1 | xclip -selection clipboard'
EOF
bash
