if [ -n "$(which yum)" ]
then
	yum install `cat ./packages` -y
else
	apt install `cat ./packages` -y
fi

# setup vim
rm -rf /usr/bin/vi
ln -s /usr/bin/vim /usr/bin/vi
cp -r ./.vim* ~

#setup copy bashrc
cat << EOF >> ~/.bashrc
bind '"\C-]":"\C-e\C-u xclip -selection clipboard <<"EOF"\n\C-y\nEOF\n"'
EOF
echo `hostname -I` `hostname` >> /etc/hosts
echo "alias xc='history 2 | cut -c 8- | head -n 1 | xclip -selection clipboard'" >> ~/.bashrc
