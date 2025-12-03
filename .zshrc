export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"

export PATH="$PATH:$HOME/.local/bin"
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/go/bin

## disbale touchpad's middle button
xinput set-button-map 11 1 0 3 4 5 6 7

alias vi=nvim
alias config='/usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME'

## set secondary monitor (3440x1440) ontop the built-in one
alias hdmi="xrandr | grep 'HDMI-A-0 connected' && xrandr --output eDP --primary --mode 1920x1200 --pos 0x0 --output HDMI-A-0 --mode 3440x1440 --pos 0x-1440 || xrandr --output eDP --primary --mode 1920x1200 --pos 0x0"
alias dp="xrandr | grep 'DisplayPort-0 connected' && xrandr --output eDP --primary --mode 1920x1200 --pos 0x0 --output DisplayPort-0 --mode 3440x1440 --pos 0x-1440 || xrandr --output eDP --primary --mode 1920x1200 --pos 0x0"

alias dockerup="DD_ENV=bqc-test docker compose -f docker-compose.yml -f docker-compose.persist.yml up -d"
alias dockerupdog="DD_ENV=bqc-test docker compose -f docker-compose.datadog.yml -f docker-compose.yml -f docker-compose.persist.yml up -d"
alias dockerdown="DD_ENV=bqc-test docker compose -f docker-compose.datadog.yml -f docker-compose.yml -f docker-compose.persist.yml down -v"


# fnm
FNM_PATH="/home/david.bui/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi
