# Aliases
# ======

# Tmux
alias ta='tmux attach'
# start tmux in unicode mode
alias t='tmux'
alias tmux='tmux -u'

# Misc.
alias irb="irb --prompt simple -f "
alias o='open'
alias s="sudo"
alias serveThis='python -m SimpleHTTPServer'
alias -s md=vim
alias fv='fg vim'
alias irb="irb --prompt simple -f "
alias speedtest='wget --output-document=/dev/null http://speedtest.wdc01.softlayer.com/downloads/test500.zip'

# Directories

alias cdd="cd ~/desktop"
alias cddr="cd ~/desktop"
alias cdo='cd ~/dotfiles'
alias cdr="cd ~/rand"

# For pasting thinks from the web
alias %=""
alias $=""

# Vim Aliases
alias e="vim"
alias v="vim"
alias em="mvim"

# History
alias hlast='fc -l 1'
alias hgrep='history | grep'

# Chmod Chown & Chgrp
alias chm="sudo chmod"
alias chm7="sudo chmod 777"
alias chm75="sudo chmod 755"
alias chmr="sudo chmod -R"
alias chmr7="sudo chmod -R 777"
alias chmr75="sudo chmod -R 755"
alias cho="sudo chown"
alias chor="sudo chown -R"
alias chg="sudo chgrp"
alias chgr="sudo chgrp -R"

# Quick exits
alias x='exit'
alias qqq='exit'

# Config edits
alias ev='vim ~/.vimrc'
alias ez='vim ~/.zshrc'
alias sz="source ~/.zshrc"

# List direcory contents
alias lsa='ls -lah'
alias l='ls -la'
alias ll='ls -l'
alias sl='ls' 
alias lns="ln -s"

# Git Stuff
alias gca='git commit -a'
alias gsa='git submodule add'
alias gclo='git clone'
alias gst='git status'
alias glog="git log --format='%Cgreen%h%Creset %C(yellow)%an%Creset - %s' --graph"
alias gpul='git pull'
alias gpus='git push'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcm='git checkout master'
alias gb='git branch'
alias gba='git branch -a'
alias ga='git add'
alias gm='git merge'
alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'
alias g='git'
alias gcount='git shortlog -sn'
alias gss='git status -s'
alias gcp='git cherry-pick'
alias glg='git log --stat --max-count=5'
alias glgg='git log --graph --max-count=5'

# Directory Stuff
alias rd='rm -rf'
alias md='mkdir -p'

alias ..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias cd/='cd /'

# Nocorrects
alias man='nocorrect man'
alias mv='nocorrect mv'
alias mkdir='nocorrect mkdir'

# Environment Variables
# =====================

export LSCOLORS=exfxcxdxbxegedabagacad
export MAILTO=saifmsajid+cron@gmail.com
export EDITOR=vim
export PAGER='less -r'
#export MANPAGER='vimpager'
#
if [[ `uname` == 'Linux' ]];
then
    export PATH=/usr/local/Cellar/ruby/1.9.3-p194/bin:$HOME/bin:/usr/local:$HOME/dotfiles/bin:/bin:/usr/local/bin:/usr/bin:/usr/sbin:/sbin:/usr/X11/bin:$HOME/bin/gsd:/Users/saif/bin:/usr/local/sbin:$HOME/dotfiles/osx;
elif [[ `uname` == 'Darwin' ]]
then 
    export PATH=/usr/local/go/bin:/usr/local/Cellar/ruby/1.9.3-p194/bin:$HOME/bin:/usr/local:$HOME/dotfiles/bin:/bin:/usr/local/bin:/usr/bin:/usr/sbin:/sbin:/usr/X11/bin:$HOME/bin/gsd:/Users/saif/bin:/usr/local/sbin:$HOME/dotfiles/osx:/var/lib/gems/1.8/gems
fi


# Misc.
# =====

bindkey -v
# alt-m to copy previous word. useful with large directory paths
bindkey "^[m" copy-prev-shell-word
# just '/etc' instead of 'cd /etc'
setopt autocd
setopt long_list_jobs

export CLICOLOR=1;
setopt no_beep
setopt multios
setopt CDABLE_VARS
# smart urls
autoload -U url-quote-magic
zle -N self-insert url-quote-magic
setopt correct_all

unsetopt menu_complete   # do not autoselect the first completion entry
unsetopt flowcontrol
setopt auto_menu         # show completion menu on succesive tab press
setopt complete_in_word
setopt always_to_end
# Completions
# ===========
autoload -Uz compinit
compinit -d ~/.dumpfile
zstyle ':completion:*' list-colors "di=34:ln=35:so=32:pi=33:ex=31:bd=34:cd=34:su=0:sg=0:tw=0:ow=0:"

## case-insensitive (all),partial-word and then substring completion
if [ "x$CASE_SENSITIVE" = "xtrue" ]; then
  zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
  unset CASE_SENSITIVE
else
  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
fi

if [ "x$COMPLETION_WAITING_DOTS" = "xtrue" ]; then
  expand-or-complete-with-dots() {
    echo -n "\e[31m......\e[0m"
    zle expand-or-complete
    zle redisplay
  }
  zle -N expand-or-complete-with-dots
  bindkey "^I" expand-or-complete-with-dots
fi

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"
# Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion::complete:*' use-cache on

# Don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm amanda apache avahi beaglidx bin cacti canna clamav daemon \
        dbus distcache dovecot fax ftp games gdm gkrellmd gopher \
        hacluster haldaemon halt hsqldb ident junkbust ldap lp mail \
        mailman mailnull mldonkey mysql nagios \
        named netdump news nfsnobody nobody nscd ntp nut nx openvpn \
        operator pcap postfix postgres privoxy pulse pvm quagga radvd \
        rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs

# ... unless we really want to.
zstyle '*' single-ignored show


# Functions
# =========
function gdv() { 
    git diff -w "$@" | view - 
}
function tab() {
  local command="cd \\\"$PWD\\\""
  (( $# > 0 )) && command="${command}; $*"

  the_app=$(
    osascript 2>/dev/null <<EOF
      tell application "System Events"
        name of first item of (every process whose frontmost is true)
      end tell
EOF
  )

  [[ "$the_app" == 'Terminal' ]] && {
    osascript 2>/dev/null <<EOF
      tell application "System Events"
        tell process "Terminal" to keystroke "t" using command down
        tell application "Terminal" to do script "${command}" in front window
      end tell
EOF
  }

  [[ "$the_app" == 'iTerm' ]] && {
    osascript 2>/dev/null <<EOF
      tell application "iTerm"
        set current_terminal to current terminal
        tell current_terminal
          launch session "Default Session"
          set current_session to current session
          tell current_session
            write text "${command}"
          end tell
        end tell
      end tell
EOF
  }
}

function quick-look() {
  (( $# > 0 )) && qlmanage -p $* &>/dev/null &
}

function man-preview() {
  man -t "$@" | open -f -a Preview
}

function trash() {
  local trash_dir="${HOME}/.Trash"
  local temp_ifs=$IFS
  IFS=$'\n'
  for item in "$@"; do
    if [[ -e "$item" ]]; then
      item_name="$(basename $item)"
      if [[ -e "${trash_dir}/${item_name}" ]]; then
        mv -f "$item" "${trash_dir}/${item_name} $(date "+%H-%M-%S")"
      else
        mv -f "$item" "${trash_dir}/"
      fi
    fi
  done
  IFS=$temp_ifs
}

function mcd() { 
  mkdir -p "$1" && cd "$1"; 
}

function showfiles() {
    defaults write com.apple.Finder AppleShowAllFiles TRUE
    killall Finder && open /System/Library/CoreServices/Finder.app
}
function hidefiles() {
    defaults write com.apple.Finder AppleShowAllFiles FALSE
    killall Finder && open /System/Library/CoreServices/Finder.app
}

function pfd() {
  osascript 2>/dev/null <<EOF
    tell application "Finder"
      return POSIX path of (target of window 1 as alias)
    end tell
EOF
}

function pfs() {
  osascript 2>/dev/null <<EOF
    set output to ""
    tell application "Finder" to set the_selection to selection
    set item_count to count the_selection
    repeat with item_index from 1 to count the_selection
      if item_index is less than item_count then set the_delimiter to "\n"
      if item_index is item_count then set the_delimiter to ""
      set output to output & ((item item_index of the_selection as alias)'s POSIX path) & the_delimiter
    end repeat
EOF
}

function cdf() {
  cd "$(pfd)"
}

function spectrum_ls() {
  for code in {000..255}; do
    print -P -- "$code: %F{$code}Test%f"
  done
}

function zsh_stats() {
  history | awk '{print $2}' | sort | uniq -c | sort -rn | head
}

# History Stuff
# =============

HISTFILE=~/.history

SAVEHIST=1000000
HISTSIZE=1000000


# Don't overwrite, append!
setopt APPEND_HISTORY
# Write after each command
setopt INC_APPEND_HISTORY
# Killer: share history between multiple shells
setopt SHARE_HISTORY
# If I type cd and then cd again, only save the last one
setopt HIST_IGNORE_DUPS
# Even if there are commands inbetween commands that are the same, still only save the last one
setopt HIST_IGNORE_ALL_DUPS
# Pretty    Obvious.  Right?
setopt HIST_REDUCE_BLANKS
# If a line starts with a space, don't save it.
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE
# When using a hist thing, make a newline show the change before executing it.
setopt HIST_VERIFY
# Save the time and how long a command ran
setopt EXTENDED_HISTORY

setopt HIST_SAVE_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS

# Prompt
# ======
# bira theme oh my zsh
# ====================

setopt prompt_subst
setopt promptsubst
setopt promptpercent

autoload colors; colors;

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

local user_host='%{$fg[green]%}%n@%m%{$reset_color%}'
local current_dir='%{$fg[blue]%}%~%{$reset_color%}'

local git_branch='$(git_prompt_info)%{$reset_color%}'

RPROMPT="[%{$fg[green]%}%@%{$reset_color%}] ${return_code}%{$reset_color%}"
PROMPT="┌─[${user_host}]—[${current_dir}]${git_branch}
└─%B%b "

ZSH_THEME_GIT_PROMPT_SUFFIX=""

# Git Prompt
function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "—[%{$fg[cyan]%}${ref#refs/heads/}%{$reset_color%}]"
}

if [[ `uname` == 'Linux' ]]
then
    local user_host='%{$fg[magenta]%}%n@%m%{$reset_color%}'
    local current_dir='%{$fg[green]%}%~%{$reset_color%}'
    RPROMPT="[%{$fg[yellow]%}%@%{$reset_color%}] ${return_code}%{$reset_color%}"
    PROMPT="┌─[${user_host}]—[${current_dir}]${git_branch}
└─%B%b "
fi

bindkey '^R' history-incremental-search-backward