# Rofi - A window switcher, Application launcher and dmenu replacement

This is my config for rofi.

Put _config, adapta-nokto and android-notifications_ files in `~/.config/rofi/`. 

Place _finder.sh_ file into `~/.local/share/rofi` and run `sudo chmod +x finder.sh`

Then afer that you can simply run program with:
`rofi -modi window,drun,find:~/.local/share/rofi/finder.sh  -show drun -sidebar-mode` or bind it to desired shortcut in i3wm and run it as that :)
For shortcuts look into config file.


![](https://i.imgur.com/xluROZh.jpg)
