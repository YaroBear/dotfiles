#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

alias pia='openvpn  /etc/openvpn/client/us3-aes-128-cbc-udp-dns.ovpn &'
alias redshift='$HOME/redshift/root/bin/redshift &'
alias bookworm='/bin/com.github.babluboy.bookworm &'
alias ff='firefox &'
alias ffdev='firefox-developer-edition &'
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
