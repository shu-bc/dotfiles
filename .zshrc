eval "$(starship init zsh)"
source <(fzf --zsh)
setopt share_history
eval "$(mise activate zsh)"
eval "$(direnv hook zsh)"
export PATH=$PATH:~/go/bin
export PATH=/usr/local/go/bin:$PATH

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/shuyou/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/shuyou/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/shuyou//google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/shuyou/google-cloud-sdk/completion.zsh.inc'; fi

alias lg='lazygit'
alias vim='nvim'
alias n='nvim'
alias c='claude'
alias kw='cd ~/workspace/kw/knowledgework/'
export EDITOR='nvim'

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

wt () {
  local n="$1"
  [ -z "$n" ] && { echo "Usage: wt <branch-name>"; return 1; }
  git worktree add -b "$n" "../$n" master
}

