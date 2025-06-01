# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi

# Lines configured by zsh-newuser-install
#HISTFILE=~/.histfile
#HISTSIZE=1000
#SAVEHIST=1000
#setopt autocd extendedglob nomatch notify
#unsetopt beep
#bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
#zstyle :compinstall filename '/home/arthur/.zshrc'

#export TERM="xterm-256color"
#export COLORTERM=truecolor

#autoload -Uz compinit
#compinit
# End of lines added by compinstall

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#Binds
bindkey '^P' autosuggest-accept

alias cdp="cd ~/documents/programs/"
alias cdpp="cd ~/documents/programs/code_scraps/python/"
alias cdpr="cd ~/documents/programs/code_scraps/rust/"
alias cicle="cd ~/documents/programs/python/cicle/ && python3 ~/documents/programs/python/cicle/main.py && cd ~"
alias snvim='f() { nvim "suda://$1"; }; f'
alias icat="kitty +kitten icat"
alias ads="cd ~/nixos-config/ && git add ."
alias rebuild="cd ~/nixos-config/ && ls -R > struct.txt && git add . && sudo nixos-rebuild switch --flake ~/nixos-config"
