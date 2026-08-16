
# ***** Environment *****
# ---------------------------------------
export TERM="xterm-256color"
# ---------------------------------------


# ***** Setup setopt *****
# ---------------------------------------
setopt autocd              # change directory just by typing its name
setopt correct             # auto correct mistakes
setopt interactivecomments # allow comments in interactive mode
setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
setopt nonomatch           # hide error message if there is no match for the pattern
setopt notify              # report the status of background jobs immediately
setopt numericglobsort     # sort filenames numerically when it makes sense
setopt promptsubst         # enable command substitution in prompt

WORDCHARS=${WORDCHARS//\/} # Don't consider certain characters part of the word
# ---------------------------------------


# ***** Hides EOL Sign ('%') *****
# ---------------------------------------
PROMPT_EOL_MARK=""
# ---------------------------------------


# ***** Configure Key Keybindings *****
# ---------------------------------------
bindkey -e                                        # emacs key bindings
bindkey ' ' magic-space                           # do history expansion on space
bindkey '^[[3;5~' kill-word                       # ctrl + Supr
bindkey '^[[3~' delete-char                       # delete
bindkey '^[[1;5C' forward-word                    # ctrl + ->
bindkey '^[[1;5D' backward-word                   # ctrl + <-
bindkey '^[[5~' beginning-of-buffer-or-history    # page up
bindkey '^[[6~' end-of-buffer-or-history          # page down
bindkey '^[[H' beginning-of-line                  # home
bindkey '^[[F' end-of-line                        # end
bindkey '^[[Z' undo                               # shift + tab undo last action
# ---------------------------------------


# ***** Enable Completion Features *****
# ---------------------------------------
autoload -Uz compinit
compinit -d ~/.cache/zcompdump
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
# ---------------------------------------


# ***** Setup History *****
# ---------------------------------------
HIST_STAMPS="mm/dd/yyyy"

HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000

setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.

# force zsh to show the complete history
alias history="history 0"

# configure `time` format
TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'
# ---------------------------------------


# ***** Zinit bootstrap *****
# ---------------------------------------
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[[ ! -d "$ZINIT_HOME" ]] && mkdir -p "$(dirname "$ZINIT_HOME")"
[[ ! -d "$ZINIT_HOME/.git" ]] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
# ---------------------------------------


# ***** Setup Plugins (Zinit) *****
# ---------------------------------------
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting

zinit snippet OMZP::git
zinit snippet OMZP::colored-man-pages
zinit snippet OMZP::vscode
zinit ice blockf
zinit light zsh-users/zsh-completions # extra completion defs (node, yarn, etc) - just fpath, no visuals/keybinds
zinit snippet OMZP::dnf              # genuinely correct here (Fedora uses dnf)

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'

eval "$(zoxide init zsh)"           # replaces autojump - use `z` instead of `j`
# ---------------------------------------


# ***** Re-run completion init *****
# ---------------------------------------
# zsh-completions above only adds a directory to fpath - compinit already ran
# once further up this file, before zinit (and this plugin) even loaded, so
# it has to run again now to actually pick up those new definitions.
compinit -d ~/.cache/zcompdump
# ---------------------------------------


# ***** Setup Aliases *****
# ---------------------------------------
alias l='lsd -l'
alias la='lsd -a'
alias lla='lsd -la'
alias lt='lsd --tree'
alias his='history'
# ---------------------------------------


export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# ***** Oh My Posh prompt (must load last) *****
# ---------------------------------------
export PATH="$HOME/.local/bin:$PATH"
eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/terminal-customization.omp.json)"
# ---------------------------------------
