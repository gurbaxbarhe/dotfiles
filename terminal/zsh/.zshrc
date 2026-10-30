export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="gurbax"
plugins=(git)

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#89ccfd"
bindkey '^I' autosuggest-accept

source $ZSH/oh-my-zsh.sh

alias .venv="source .venv/bin/activate"
alias venv="source venv/bin/activate"
alias fe="cd scriptrunner-frontend"
alias be="cd scriptrunner-backend"
alias fleet="cd script-runner-fleet"
alias dispatcher="cd script-runner-dispatcher"
alias design="cd script-runner-design-system"

alias cr="claude --resume"

# Git aliases (override oh-my-zsh git plugin defaults).
alias s='git status -sb'

alias ga='git add -A'
alias gap='ga -p'

alias gbr='git branch -v'
alias gbd='git branch -D'

unalias gc 2>/dev/null
function gc {
  git diff --cached | grep '\btap[ph]\b' >/dev/null &&
    echo "\e[0;31;29mOops, there's a #tapp or similar in that diff.\e[0m" ||
    git commit -v "$@"
}

alias gch='git cherry-pick'

alias gcm='git commit -v --amend'
alias gcom='git commit -a -m'

alias gc='git checkout'

alias gd='git diff -M'
alias gd.='git diff -M --color-words="."'
alias gdc='git diff --cached -M'
alias gdc.='git diff --cached -M --color-words="."'

alias gf='git fetch'

git_current_branch() {
  cat "$(git rev-parse --git-dir 2>/dev/null)/HEAD" | sed -e 's/^.*refs\/heads\///'
}

alias glog='git log --date-order --pretty="format:%C(yellow)%h%Cblue%d%Creset %s %C(white) %an, %ar%Creset"'
alias gl='glog --graph'
alias gla='gl --all'

alias gm='git merge --no-ff'
alias gmf='git merge --ff-only'

alias gp='git push'
alias gpthis='gp origin $(git_current_branch)'
alias gpthis!='gp --set-upstream origin $(git_current_branch)'

alias grb='git rebase -p'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase -i'

alias gr='git reset'
alias grh='git reset --hard'
alias grsh='git reset --soft HEAD~'

alias grv='git remote -v'

alias gs='git show'
alias gs.='git show --color-words="."'

alias gst='git stash'
alias gstp='git stash pop'

alias gup='git pull'

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

if [ -f '/Users/gurbaxbarhe/Desktop/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/gurbaxbarhe/Desktop/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/Users/gurbaxbarhe/Desktop/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/gurbaxbarhe/Desktop/google-cloud-sdk/completion.zsh.inc'; fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
export PATH="$HOME/.local/bin:$PATH"

export BAT_THEME="GitHub-Dark"
source /opt/homebrew/share/google-cloud-sdk/path.zsh.inc
source /opt/homebrew/share/google-cloud-sdk/completion.zsh.inc
