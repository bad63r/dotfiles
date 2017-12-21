# **My nooby guide for i3wm**

This is my knowledge collected over some time using i3 wm. You can find all of this on the internet with a little bit of persistance, but here it's on one place. My
every configuration file for mentioned programs can be found in my [dotfiles](https://github.com/bad63r/dotfiles). Also you should be aware that this guide is focused
on Debian based systems or more preciesly in this case Ubuntu.

### **Dunst** 

[Dunst](https://dunst-project.org) is a lightweight replacement for the notification-daemons.

Configuring dunst:

First we need to install it

`sudo apt-get install dunst`

Add .dunstrc to your home folder.That's it. You don't need to include any line into i3 config file.
	
	#go into this location
sudo vim /usr/share/dbus-1/services/org.freedesktop.Notifications.service
		#change exec line to dunst location, check dunst location with command called "whereis"

FIXING LID CLOSED FUNCTION
	#go to /etc/systemd/logind.conf
sudo vim /etc/systemd/logind.conf
	#uncomment line "HandleLidSwitch" and change "suspend" to "ignore"
	#for changes go into effect
systemctl restart systemd-logind

FISH SHELL
	#install fish shell
sudo apt-get install fish
	#after that, we want to instal oh-my-fish for easier configuration or fisherman
	#for that we need curl
sudo apt-get install curl
	#and git
sudo apt-get install git
	#after that go on github page of oh-my-fish and scroll little bit down and search for install paragraph
	#copy text into terminal for making fish shell your default shell
chsh -s `which fish`
		#if you want to reverse the changes just type
chsh -s (which bash)
	#fish configuration is in
~/.config/fish/config.fish
	#showing full path in fish
funced prompt_pwd
	#replace shown result with
function prompt_pwd --description 'Print the current working directory, NOT shortened to fit the prompt'
    if test "$PWD" != "$HOME"
        printf "%s" (echo $PWD|sed -e 's|/private||' -e "s|^$HOME|~|")
    else
        echo '~'
    end

end
	#type enter

	
	
TOUCHPAD

#type command
synclient -l
	#that will show us what all we can change
	#type 
synclient TapButton1=0
	#to disable touch on tap 
  #to have this behavior on startup, you need to add this line as a script(.sh) to /usr/local/bin/
      #e.g. /usr/local/bin/touchRegulation.sh

VIVADO

#download ~20Gb Vivado installation file for all OS and find xsetup script and run it(as root)
#after installation is done, do :
		#it has to be bash shell for running vivado
		#sudo dpkg --add-architecture i386
		#sudo apt-get update
		#sudo dpkg --add-architecture i386, run sudo apt-get update and sudo apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386
		#sudo apt-get install libstdc++6:i386 libfontconfig1:i386 \
libXext6:i386 libxext6:i386 libice6:i386 libXrender1:i386 \
 libglib2.0-0:i386 libsm6:i386 libsm6:i386
		
		#installing cable driver(you can't do that during installation if you didn't start install script as root, if you started script with root i think you would have that option
			#cd /opt/Xilinx/Vivado/2015.1/data/xicom/cable_drivers/lin64/install_script/install_drivers/
			#sudo ./install_drivers


		#starting vivado
		#source /opt/Xilinx/Vivado/2015.1/settings64.sh
		#vivado & 
		#both commands you have to do in bash shell

#VIBER

#download viber from official website for linux
#install it with sudo dpkg -i viber.deb

#after that you need to fix sound issue
#go to 
sudo vim /etc/pulse/default.pa
# find line load-module module-udev-detect and change it to : load-module module-udev-detect tsched=0










