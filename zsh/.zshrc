if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)

source $ZSH/oh-my-zsh.sh

export PATH=/home/pete/.cargo/bin:$PATH

source ~/powerlevel10k/powerlevel10k.zsh-theme

alias cls="clear"
alias goldwarden="flatpak run --command=goldwarden com.quexten.Goldwarden"
alias gits="git status -vv"
alias gita="git add --all"
alias gitc="git commit -m"
alias gitps="git push"
alias gitpl="git pull"
alias gitf="git fetch"
alias gitx="git stash save --keep-index --include-untracked;git stash drop"
alias gitoops="git reset HEAD~1;git push --force"

eval $(thefuck --alias)

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source ~/.zoxiderc
