# Ranger config files
Afer installing ranger(file manager) you should do 
`ranger --copy-config=all` 

That will copy default config files into your ``` ~/.config/```. Editing those files will overwrite default ones. 
You need to configure only two of those files: *rc.conf* and *rifle.conf*.
Place those two files into ```~/.config/ranger```

In this config pdf previewing is done like "work around" thing. Since version 1.9 ranger supports this option by default. Add this line to `~/.config/ranger/scope.sh`

`# application/pdf)
#     pdftoppm -f 1 -l 1 \
#              -scale-to-x 1920 \
#              -scale-to-y -1 \
#              -singlefile \
#              -jpeg -tiffcompression jpeg \
#              -- "${FILE_PATH}" "${IMAGE_CACHE_PATH%.*}" \
#         && exit 6 || exit 1;;`
