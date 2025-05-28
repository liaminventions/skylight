
# skylight  
![](https://github.com/liaminventions/skylight/blob/main/images/example.png?raw=true)

https://github.com/user-attachments/assets/144a870a-610a-410d-8517-c46b155c8d56

A Frutiger-Aero style Linux rice.
Credits to [diinki's frutiger aero rice](https://github.com/diinki/diinki-aero) for some css styles and configs.

managed by [chezmoi](https://github.com/twpayne/chezmoi).

## NOTE: this has a LOT of system sounds, but do not fret as they are all adjustable and togglable in the menu) 

## keyboard layout:

![](https://raw.githubusercontent.com/liaminventions/skylight/main/layout.svg)

# Install 
## NOTE: the steps here are based on a basic install of arch liunx. although the steps will be similar on other distros, they might not be exactly the same. 
## get required software
these packages need to be installed: (some of which is from the AUR)
```
Hyprland waybar kitty wofi eww swaylock-effects ttf-font-awesome ttf-roboto-mono ttf-roboto-mono-nerd zsh pulseaudio pavucontrol nwg-look nwg-displays librewolf networkmanager network-manager-applet bluez blueman swww dunst sddm sddm-conf-git btop wf-recorder grim slurp grimblast
```

## clone repo
run: 
``` 
git clone https://github.com/liaminventions/skylight.git ~/.local/share/chezmoi
```

## user name

before doing anything else, run these commands:
```
cd ~/.local/share/chezmoi
find . -type f -name "*" -exec sed -i -e 's//guest/<YOURUSERNAME>/g' {} + 
```
replacing `<YOURUSERNAME>`with your user name. (not root)

## apply to system
run
```
chezmoi apply
```

## system-wide folders

this repo contains `usr` and `etc` directories.

to install these onto the system, run: 

```
sudo cp -r ~/etc/** /etc
sudo cp -r ~/usr/** /usr
```

`etc` contains `etc/default/grub`, `mkinitcpio.conf`, and a getty login dropin file. 

although that is not very useful here since we are using `sddm`.

it also contains `99-device-hooks.rules`, which plays sounds when you insert/remove usb devices.

to enable this, run 

```
sudo chown root:root ~/usb_sound.sh
sudo udevadm control --reload
sudo udevadm trigger
```
after copying the folders.


as for `usr`, (`lidswitch.sh`) is in it that re-enables the lid switch after hibernating (if you don't have proper driver support)

this fixes an issue where systemd suspends instead of hibernating if you close the lid right before `systemctl hibernate` is ran (in `~/.config/hypr/scripts/hibernate`) 

it also has some system-wide sounds like shutdown and usb sounds.

to enable the shutdown sound, run 
```
sudo systemctl enable shutdown_sound
```
then reboot

## fonts 

i have included most required fonts in the `fonts` directory.
to install these, run this command:
``` 
sudo cp ~/fonts/** /usr/share/fonts
```

as for the others, those were already installed in the first step.

## themes 

in `nwg-look`, set:

 - the `Widgets` theme to `diinki-aero` 
 - the `Icon theme` to `Windows-7`
 - the `Mouse cursor` to `Windows 7 Aero - Default`

you can also set the default font (found in `Widgets`) to `Frutiger LT Std 55 Roman` (11pt) 

## hibernation
TODO: FIX AND TEST

run the `hibernator` script if you have swap set up and want hibernation functionality

```
sudo ./hibernator
```

to apply changes, update grub with

`sudo grub-mkconfig -o /boot/grub/grub.cfg` or `sudo update-grub`

rebuild initramfs,
```
sudo mkinitcpio -P
```
and reboot.

## nm-applet 

you might want to disable annoying "connection activated" notifications if they appear.
 
those can be disabled with
 
```
gsettings set org.gnome.nm-applet disable-disconnected-notifications "true"
gsettings set org.gnome.nm-applet disable-connected-notifications "true"
```

## wf-recorder

be sure to select the correct audio source with `pavucontrol` when screen recording.

to do this, go to pavucontrol and to the "Recording" tab (while screen recording) and select the correct audio source.

for example:

![](https://github.com/liaminventions/skylight/blob/main/images/pa.png?raw=true)

also, you only have to do this once, the settings will save. 

(unless you want to change sources, or have different devices connected)

## missing drivers/firmware on some laptops

on my hp-dy2024nr, the power button and lid does nothing, so, i made a fix.

to enable it, just uncomment the `source=~/.config/hypr/missingdriversfix.conf` line in `hyprland.conf`
