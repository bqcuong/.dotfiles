export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

## disbale touchpad's middle button
xinput set-button-map 11 1 0 3 4 5 6 7

## set secondary monitor (3440x1440) ontop the built-in one
alias hdmi="xrandr | grep 'HDMI-A-0 connected' && xrandr --output eDP --primary --mode 1920x1200 --pos 0x0 --output HDMI-A-0 --mode 3440x1440 --pos 0x-1440 || xrandr --output eDP --primary --mode 1920x1200 --pos 0x0"
alias dp="xrandr | grep 'DisplayPort-0 connected' && xrandr --output eDP --primary --mode 1920x1200 --pos 0x0 --output DisplayPort-0 --mode 3440x1440 --pos 0x-1440 || xrandr --output eDP --primary --mode 1920x1200 --pos 0x0"

## aliases
alias vi=nvim
alias config='/usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME'

## personal configs
source ~/.zsh_private
