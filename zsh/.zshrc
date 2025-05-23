export GPG_TTY=$(tty)

# P10K Instant prompt stuff
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# ENV
export EDITOR="nvim"
export VISUAL="nvim"
export PATH=/home/pete/.cargo/bin:$PATH
export RLWRAP_HOME="$HOME/.config/rlwrap"

# Aliases and functions
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

alias cls="clear"
alias gits="git status"
alias gitd="git difftool --no-symlinks --dir-diff HEAD || git status"
alias gita="git add --all"
alias gitc="git commit -m"
alias gitps="git push"
alias gitpl="git pull"
alias gitf="git fetch"
alias gitx="git stash save --keep-index --include-untracked;git stash drop"
alias gitoops="git reset HEAD~1;git push --force-with-lease"
alias gitl="git log"
alias va="source .venv/bin/activate"
alias vd="deactivate"
alias vac="source .venv/bin/activate;codium ."
alias kd="kitten diff"
alias fnvim="cd ~; fzf | xargs nvim"
alias fcat="cd ~; fzf | xargs cat"
alias ppttopdf="libreoffice --headless --convert-to pdf"
alias mk="mkdir"
alias tmr="tereminder"

# Private aliases
source ~/.zsh_priv_aliases

# P10K config
source ~/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Zoxide
source ~/.zoxiderc

# FZF
source <(fzf --zsh)
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
fzf-history-widget-accept() {
  fzf-history-widget
  zle accept-line
}
zle     -N     fzf-history-widget-accept
bindkey '^X^R' fzf-history-widget-accept

# kubectl
source <(kubectl completion zsh)
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Set Vi bindings in terminal
bindkey -v

# PWD=$HOME/XMOS/XTC/15.3.1 source $HOME/XMOS/XTC/15.3.1/SetEnv

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# cuda
export CUDA_HOME=/opt/cuda
export PATH=$CUDA_HOME/bin:$PATH
export LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH
