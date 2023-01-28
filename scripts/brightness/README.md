### Brightness script configuration

* in order script to work you need to install *light* program which controls backlight
`sudo apt install light`
* add current user to video group
`sudo usermod -a -G video $USER`
* you need to restart computer in order for user to be visible in video group
* put script into ~/home/bad63r/.i3/
