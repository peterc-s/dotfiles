# Environment Variables
set -gx GPG_TTY (tty)
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx PATH $HOME/.cargo/bin $PATH
set -gx RLWRAP_HOME "$HOME/.config/rlwrap"

if status is-interactive
end

# Aliases
alias cls="clear"
alias gits="git status"
alias gitd="git difftool --no-symlinks --dir-diff HEAD || git status"
alias gita="git add --all"
alias gitc="git commit -m"
alias gitps="git push"
alias gitpl="git pull"
alias gitf="git fetch"
alias gitx="git stash save --keep-index --include-untracked; git stash drop"
alias gitoops="git reset HEAD~1; git push --force-with-lease"
alias gitl="git log"
alias va="source .venv/bin/activate.fish"
alias vd="deactivate"
alias vac="source .venv/bin/activate.fish; codium ."
alias kd="kitten diff"
alias fnvim="cd ~; fzf | xargs nvim"
alias fcat="cd ~; fzf | xargs cat"
alias ppttopdf="libreoffice --headless --convert-to pdf"
alias mk="mkdir"
alias tmr="tereminder"

# Yazi function
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set -q cwd; and test -n "$cwd" -a "$cwd" != "$PWD"
        builtin cd -- "$cwd"
    end
    rm -f "$tmp"
end

# Zoxide initialization
zoxide init fish --cmd=cd | source

# FZF Configuration
set -gx FZF_DEFAULT_OPTS "--reverse"
set -gx FZF_ALT_C_OPTS "--preview 'tree -C {} | head -200'"

# Kubectl configuration
kubectl completion fish | source
set -gx PATH $HOME/.krew/bin $PATH

# Vi mode
fish_vi_key_bindings

# CUDA configuration
set -gx CUDA_HOME /opt/cuda
set -gx PATH $CUDA_HOME/bin $PATH
set -gx LD_LIBRARY_PATH $CUDA_HOME/lib64 $LD_LIBRARY_PATH

# Private aliases
source ~/.config/fish/priv_aliases.fish

if type -q nvm
    nvm use latest >/dev/null
end

# Starship
starship init fish | source

# Fix stupid starship newlines
set -g __cmd_executed false

function mark_command_start --on-event fish_preexec
    set -g __cmd_executed true
end

function fish_prompt
    if test "$__cmd_executed" = true
        echo
    end

    set -g __cmd_executed true

    starship prompt --status=$status --cmd-duration=$CMD_DURATION --jobs=(count (jobs -p))
end

# XMOS Environment
# bass source $HOME/XMOS/XTC/15.3.1/SetEnv
