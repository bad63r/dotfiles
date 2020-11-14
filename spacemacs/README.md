# Spacemacs

My spacemacs config. Copy spacemacs file from this git repo into *~/.spacemacs*.

Added new packages and some shortcuts.

I figured out how to run spacemacs as a server on Linux. That enables me to run neatly spacemacs in one frame, opening all files from gui file browser and from 
spacemacs itself.

- First, to even enable that feauture to run as a server, you need to add two lines in your ~/.spacemacs configuration file in **
(defun dotspacemacs/init ()** section. Or just copy my config ...
```
   dotspacemacs-enable-server t
   dotspacemacs-persistent-server t
```

- After that you need to configure shorcut that is called when you invoke the solo spacemacs or when opening in gui file browswer. To do that, locate yourself in
*/usr/share/applications/*. Then copy **emacs.desktop** file from this git repo into */usr/share/applications/*.

- Now after you have done that you need to finish last step and that is to place **emacsclient_script.sh** from this git repo into */usr/local/bin*
  For that you would need to use sudo. Emacs.desktop file is calling for **emacsclient_script.sh** so that is the reason why we need to copy it. It can be any 
  location just then you need to change in emacs.desktop the path where this script is located.
  
- And to make it even more convenient, make alias in your *~/.bashrc*. Find where are other aliases located and add line as below or copy my **.bashrc** file to \
that location.
```
alias emacs='/usr/local/bin/emacsclient_script.sh'
```
- Done :)


