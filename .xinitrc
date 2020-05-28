systemctl --user import-environment DISPLAY
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

xrandr --dpi 144
xcalib -d :0 $HOME/.config/color/icc/Dell_XPS_13_2017_RXN49_LQ133Z1.icm

setxkbmap -option compose:ralt &
eval $(ssh-agent)
exec i3
