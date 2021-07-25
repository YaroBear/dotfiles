#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /usr/share/powerline/bindings/bash/powerline.sh

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

export EDITOR=nvim

alias pia='openvpn  /etc/openvpn/client/us3-aes-128-cbc-udp-dns.ovpn &'
alias bookworm='/bin/com.github.babluboy.bookworm &'
alias ff='firefox &'
alias ffdev='firefox-developer-edition &'
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
. "$HOME/.cargo/env"
