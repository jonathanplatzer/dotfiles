systemctl --user import-environment DISPLAY
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

xrandr --dpi 144

setxkbmap -option compose:ralt &
eval $(ssh-agent)
exec i3
