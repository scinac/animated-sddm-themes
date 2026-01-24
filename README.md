# animated-sddm-themes

Animated anime themes, qt6 themes for the sddm display manager
One theme for now, an animated senjougahara (monogatari series) theme, created for 1920x1080 pixel but should work fine with many different resolutions

# Preview

https://github.com/user-attachments/assets/01fa49da-a448-4f80-b57a-510d87dfee21

[▶ Download demo](https://github.com/scinac/animated-sddm-themes/blob/main/previews/senjougaharaPreview.mp4)

# Installation

I will make a script for auto Installation soon for now:

clone this repo

put the cloned repo in your /usr/share/sddm/themes folder

then edit (or create) the file /etc/sddm.conf.d/default.conf and add this to it:

```
[Theme]
Current=animated-sddm-themes

```

# Change theme

Also have no nice automation for that as of now but its very easy

edit the Main.qml file and on line 18 change the conf file to the one you want

```
  Component.onCompleted: {
    config.loadConf("/usr/share/sddm/themes/animated-sddm-themes/themeConfigs/frieren.conf")

```

