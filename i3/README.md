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
* for showing full path in fish type `funced prompt_pwd` and replace shown result with
```
function prompt_pwd --description 'Print the current working directory, NOT shortened to fit the prompt'
    if test "$PWD" != "$HOME"
        printf "%s" (echo $PWD|sed -e 's|/private||' -e "s|^$HOME|~|")
    else
        echo '~'
    end

end
```

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

* install it with `sudo apt install youtube-dl`
* to see all available options type `man youtube-dl`
* to download video: `youtube-dl -F` to see all available formats to download. After that `youtubedl -f name_of_code "link_URL" `
* to download audio: `youtube-dl -x "url"`

### Moc - command line music player

* install it with `sudo apt install moc`
* run it with `mocp`









