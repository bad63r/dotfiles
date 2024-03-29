# **My nooby guide for i3wm**

This is my knowledge collected over some time using i3 wm. You can find all of this on the internet with a little bit of persistance, but here it's on one place. My
every configuration file for mentioned programs can be found in my [dotfiles](https://github.com/bad63r/dotfiles). Also you should be aware that this guide is focused
on Debian based systems or more preciesly in this case Ubuntu.

### Power shorcuts in i3wm

* to use shutdown and reboot without sudo
* 
  `# Cmnd alias specification`

  `Cmnd_Alias POWER = /sbin/shutdown\, /sbin/reboot`
  
  `YOUR_USER ALL=NOPASSWD: POWER` 

* Add those lines to `/etc/sudoers`
### Dunst 

[Dunst](https://dunst-project.org) is a lightweight replacement for the notification-daemons.

Configuration:
* install Dunst `sudo apt-get install dunst`
* add **.dunstrc** to your home folder
* rest of the bullets below seems depricated by now[I have tried this on ubuntu 22.04 hp-elitebook 830 G8]
  * change notification manager going to
`sudo vim /usr/share/dbus-1/services/org.freedesktop.Notifications.service` and change _**exec**_ line to dunst location. Check dunst location with command called "whereis"
  * install fonts for better looking dunst: `sudo apt-get install fonts-hack-ttf`

### Fixing lid closed function

* go to  _/etc/systemd/logind.conf_
`sudo vim /etc/systemd/logind.conf`
* uncomment line "HandleLidSwitch" and change "suspend" to "ignore"
* after configuring you need to restart for changes to get effect
`systemctl restart systemd-logind`

### Fish shell

* install Fish shell `sudo apt-get install fish`
* after that, we want to install **oh-my-fish** for easier configuration(for that we need **_curl_** and **_git_**)

`sudo apt-get install curl`

`sudo apt-get install git`

* after that go on github page of oh-my-fish and scroll little bit down and search for install paragraph
* copy text into terminal for making fish shell your default shell
```
chsh -s `which fish`
```
* if you want to reverse the changes just type
`chsh -s (which bash)`
* fish configuration is in _~/.config/fish/config.fish_
* for showing full path in fish shell type:`set -U fish_prompt_pwd_dir_length 0` 
* type enter

### Touchpad

* type command `synclient -l`

That will show us what all we can change.

* type `synclient TapButton1=0`to disable touch on tap. To have this behavior on startup, you need to add this line as a script(.sh) to _/usr/local/bin/_

e.g. _/usr/local/bin/touchRegulation.sh_

### Vivado

* download ~20Gb Vivado installation file(previous versions are smaller) for all OS and find xsetup script and run it(as root and in the Bash shell)
* after installation is done, **DO NOT RUN VIVADO YET** you need to install rest of the goodies first.

`sudo dpkg --add-architecture i386`

`sudo apt-get update`

`sudo dpkg --add-architecture i386`

`sudo apt-get update`

`sudo apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386`

`sudo apt-get install libstdc++6:i386 libfontconfig1:i386 \
libXext6:i386 libxext6:i386 libice6:i386 libXrender1:i386 \
 libglib2.0-0:i386 libsm6:i386 libsm6:i386`
		
* installing cable driver(you can't do that during installation if you didn't start install script as root, if you started script with root I think you would have that option

`cd /opt/Xilinx/Vivado/2015.1/data/xicom/cable_drivers/lin64/install_script/install_drivers/`

`sudo ./install_drivers`

* starting vivado `source /opt/Xilinx/Vivado/2015.1/settings64.sh`

`vivado &`

* both commands you have to do in bash shell

### Viber

* download Viber from official website for Linux
* install it with `sudo dpkg -i viber.deb`
* after that you need to fix sound issue for ThinkPad laptop on Viber
* type `sudo vim /etc/pulse/default.pa`
* find line _load-module module-udev-detect_ and change it to _load-module module-udev-detect tsched=0_

### Youtube-dl - command line YouTube downloader

* install it with: 
`sudo apt install python-pip`

`sudo pip install youtube-dl`
* to see all available options type `man youtube-dl`
* to download video: `youtube-dl -F` to see all available formats to download. After that `youtubedl -f name_of_code "link_URL" `
* to download audio: `youtube-dl -x "url"`

### Cmus - command line music player

* install it with `sudo apt install cmus`
* run it with `cmus`

### Theming my i3wm

* theme: Graybird [GTK2/3]
* icons: Flat-Remix-Blue-Light [GTK2/3]
* terminal font(in temrinal): Hack

### Speeding up system

* install _preload_ - program which loads programs into ram before use
`sudo apt install preload`

### Tlp - power managment

* install tlp: `sudo apt install tlp`
* to enable it type: `sudo systemctl start tlp`
* check if it is active: `sudo systemctl status tlp`
* to make it autostart as service on every boot: `sudo systemctl enable tlp`
* to check if it is really working install power top and check last card "tunables": `sudo apt install powertop`

Tlp is active only when laptop is working on battery. As soon as you are on AC it is not working. Because it is focused on power saving, there can be performance droping in favour of battery life when your laptop is using only battery.

### Fsearch - Powerful tool for searching 

### i3-workspace-names-daemon

* check github page for installation and all settings
* in my dotfiles there is configuration file(fallow README file from there)
`sudo pip3 install i3-workspace-names-daemon`

### adding sudo password prompt to programs that need it

* install packages:

`sudo apt install policykit-desktop-privileges`
`sudo apt install policykit-1-gnome`

### Fix urxvt (rxvt-unicode) to show correct icon in rofi -show windows mode
* change file  `/usr/local/applications/rxvt-unicode.desktop`
* find line which begins with Icon= and change it to `Icon=bash` ; more detail or icon to chose you can find in `/usr/share/icons`
* for system to notice update do `sudo update-desktop-database`


### sound and brightness controls are set up in i3wm config file(go to github.com/bad63r/dotfiles/scripts and read guidline for each script)
* brightness.sh
* volumeUp.sh

* add this to end of your i3wm config if it is not already added

`exec --no-startup-id /usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &`



### Dependencies 

* yt-dlp
* xclip

### Display Configuration Switching Setup

* install arandr (gui for xrand which lets you manually setup your display layout): `sudo apt install arandr`
* install autorandr (program which switch display layout automatically once detected): `sudo apt install autorandr`
  * when you have your display layout ready(e.g. wihtout additional monitors), just execute command in terminal: `autorandr --save mysetup`
  * when layout config is saved, type: `autorandr --default mysetup` 
  * after that attach all your monitors and type: `autorandr --save docked_setup`
  * and you are finished. autorandr is already running in background and will auto switch as he recognize new setup 
  * in order to correct your background image after switching display config, there is an option to create script which will be executed after the switch is done
    * create bash script called postswitch(NOTICE: there is no .sh as extension) in: `/home/bad63r/.config/autorandr/`
	* content of the postswitch script which will autoalign correct wallpaper with Nitrogen: 
	`#!/bin/bash `
	`nitrogen --restore`

### Keyboard layouts

* After you install gxkb to support graphic depiction of setxkbmap you need to right click on setxkbmap to access its settings
* By default last tab, enable system keybaord is disable. Enable it
* Now all should work fine
* if you dont want gxkb and setxkbmap together in system tray, just disable sys tray icon from the same settings

### External display cursor issue(solution from stackoverflow)


I ended up solving it myself (kind of). It's not the ultimate way, but it's a workaround that I can live with myself.
Essentially, I took the original sources of the DMZ-Cursors package and created a fork of DMZ-Black, then I removed the 32x32 and 42x42 images, and am now using that as my cursor set.
For convenience sake, I've put up my version of DMZ-Black on Github:  [LINK](https://github.com/codecat/dmzblack-96dpi)

If you wish to do the same with DMZ-White, simply download the sources [here](https://bugs.launchpad.net/ubuntu/+archive/primary/+files/dmz-cursor-theme_0.4.3.tar.gz), copy DMZ-White, and remove all lines mentioning 32x32 and 42x42 in the *.in files. You can also remove the folders for those images if you want. Then simply run make.sh and copy the generated cursor files (in ../xcursors) to your cursors folder. (You can take my install script and change_cursor.sh as an example.)



