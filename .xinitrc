systemctl --user import-environment DISPLAY
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

xrandr --output DP-0 --scale 1.5x1.5 --rotate right --right-of DP-2

setxkbmap -option compose:ralt &
eval $(ssh-agent)
exec i3
