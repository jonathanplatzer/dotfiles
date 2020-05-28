systemctl --user import-environment DISPLAY
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

setxkbmap -option compose:ralt &
eval $(ssh-agent)
exec i3
