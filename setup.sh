# setup packages
packages=`curl https://raw.githubusercontent.com/huynp1999/dotfiles/master/packages`
common=`echo $packages | tr '.' '\n' | sed -n '1p' `
deb=`echo $packages | tr '.' '\n' | sed -n '2p' | cut -d' ' -f2-`
rpm=`echo $packages | tr '.' '\n' | sed -n '3p' | cut -d' ' -f2-`
if [ -n "$(which yum)" ]
then
	yum install $common $rpm -y
else
	apt update; apt install $common $deb -y
fi

# setup vim
rm -rf /usr/bin/vi
ln -s /usr/bin/vim /usr/bin/vi
cp -r ./.vim* ~

# setup bashrc
ip_hostname=$(hostname -I)+$(hostname)
if grep -Fxq "$ip_hostname" /etc/hosts
then
	echo `hostname -I` `hostname` >> /etc/hosts
fi

wget https://raw.githubusercontent.com/huynp1999/dotfiles/master/bash/.bashrc -o ~/.bashrc
. ~/.bashrc
