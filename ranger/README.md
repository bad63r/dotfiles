# Ranger config files
Afer installing ranger(file manager) you should do 
`ranger --copy-config=all` 

That will copy default config files into your ``` ~/.config/```. Editing those files will overwrite default ones. 
You need to configure only two of those files: *rc.conf* and *rifle.conf*.
Place those two files into ```~/.config/ranger```

In this config pdf previewing is done like "work around" thing. Since version 1.9 ranger supports this option by default. Uncomment lines in `~/.config/ranger/scope.sh` in section pdf) to have previewing pdf works :) 

To delete files with <DELETE> please install trash-cli with `sudo apt install trash-cli`
