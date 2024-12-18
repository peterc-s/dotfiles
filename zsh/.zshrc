if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)

source $ZSH/oh-my-zsh.sh

export PATH=/home/pete/.cargo/bin:$PATH
export RLWRAP_HOME="$HOME/.config/rlwrap"

source ~/powerlevel10k/powerlevel10k.zsh-theme

alias cls="clear"
alias goldwarden="flatpak run --command=goldwarden com.quexten.Goldwarden"
alias gits="git status"
alias gitd="git difftool --no-symlinks --dir-diff HEAD || git status"
alias gita="git add --all"
alias gitc="git commit -m"
alias gitps="git push"
alias gitpl="git pull"
alias gitf="git fetch"
alias gitx="git stash save --keep-index --include-untracked;git stash drop"
alias gitoops="git reset HEAD~1;git push --force-with-lease"
alias va="source .venv/bin/activate"
alias vd="deactivate"
alias vac="source .venv/bin/activate;codium ."
alias kd="kitten diff"

source ~/.zsh_priv_aliases

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source ~/.zoxiderc

POWERLEVEL9K_INSTANT_PROMPT=quiet
bindkey -v
$(which tereminder)
