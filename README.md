# animated-sddm-themes

Animated anime themes, qt6 themes for the sddm display manager

### remember qt6, doesnt really work for qt5

One theme for now, an animated senjougahara (monogatari series) theme, created for 1920x1080 pixel but should work fine with many different resolutions

# Preview

https://github.com/user-attachments/assets/73ae6096-51a1-4e26-946c-544c0257b6cc

[▶ Download demo](https://github.com/scinac/animated-sddm-themes/blob/main/previews/senjougaharaPreview.mp4)

# Installation

### clone this repo

#### Run the depedencyInstallScript 

`chmod +x ./installDependencies.sh`

`sudo ./installDependecies.sh`

### Run the script 

`sudo ./installTheme.sh`

#### might have to make it an executable first with 

`chmod +x ./installTheme.sh`

#### thats pretty much it, reboot or restart sddm and it should work

`sudo systemctl restart sddm`



### If the script doesnt work for whatever reason, manual installation:
put the cloned repo in your /usr/share/sddm/themes folder

then edit (or create) the file /etc/sddm.conf and /etc/sddm.conf.d/theme (something) and add this to it:

```
[Theme]
Current=animated-sddm-themes

```

# Change theme

`chmod +x ./changeTheme`

`./chageTheme.sh ThemeName`

### possible themenames = frieren, makima, senjougahara

### remember to do this either: in /usr/share/sddm/themes/animated-sddm-themes directory or afterwards run the install script again


