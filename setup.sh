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
cd ~/dotfiles 2>/dev/null
if [ $? -eq 0 ]
then
	cp -r ~/dotfiles/vim/.vim* ~/
else
	echo "dotfiles repo does not exist in ~/"
fi 

# setup bashrc
ip_hostname=$(hostname -I)+$(hostname)
if grep -Fxq "$ip_hostname" /etc/hosts
then
	echo `hostname -I` `hostname` >> /etc/hosts
fi

wget https://raw.githubusercontent.com/huynp1999/dotfiles/master/bash/.bashrc -O ~/.bashrc
. ~/.bashrc

# setup byobu
mkdir ~/.byobu/bin
wget https://raw.githubusercontent.com/huynp1999/dotfiles/master/byobu/.byobu/bin/simple_dv -O ~/.byobu/bin/simple_dv
DISABLE_STT="logo release disk load_average cpu_count cpu_freq memory uptime raid reboot_required updates_available"
ENABLE_STT="simple_dv ip_address"
STTPATH="$(echo ~)/.byobu/status"
for i in $DISABLE_STT
do
        sed -i '/#tmux_right/d'  $STTPATH
        sed -i "/tmux_right/ s/$i/#$i/g" $STTPATH
        sed -i "/tmux_left/ s/$i/#$i/g" $STTPATH
done
j=1
for i in $ENABLE_STT
do
        # first status for tmux_left
        if [ $j -eq 1 ]
        then
                sed -i "/tmux_left/ s/ session/ $i session/g" $STTPATH
                j=2
        fi
        sed -i "/tmux_right/ s/#$i/$i/g" $STTPATH
done
