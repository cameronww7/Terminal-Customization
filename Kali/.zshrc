

# ***** Path to your oh-my-zsh installation *****
# ---------------------------------------
export ZSH="/home/$USER/.oh-my-zsh"
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


# ***** Setup ZSH Base *****
# ---------------------------------------
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# Also see for status - https://gitmemory.com/issue/bhilburn/POWERLEVEL9K/501/500341341
ZSH_THEME="POWERLEVEL9K/POWERLEVEL9K"
POWERLEVEL9K_MODE="awesome-fontconfig"
# ---------------------------------------

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes


# ***** Setup Custom Displays *****
# ---------------------------------------
# ***** Internet Signal Display *****
prompt_zsh_internet_signal(){
  local symbol="\uf7ba"
  local strength="iwconfig wlp5s0 | grep -i 'link quality' | grep -o '[0-9]*/[0-9]*'"
  
  echo -n "%F{white}\uE0B3 $symbol $strength"
}

prompt_vpnip(){
  local OUT="$(ip a show tun0 up 2>&1)";
  if [[ $OUT == *"does not exist."* ]]; then
    local content="No-VPN"
  else
    local content="$(ip addr show tun0 | grep 'inet\b' | awk '{print $2}' | cut -d/ -f1)" 
  fi
  $1_prompt_segment "$0" "$2" "black" "green1" "$content" "#"
}

# ***** TryHarder Display *****
prompt_tryHarder() {
    local content='%F{46}\uF17C TryHard3r'
    $1_prompt_segment "$0" "$2" "black" "white" "$content" "#"
}
# ---------------------------------------


# ***** Setup POWERLEVEL9K *****
# ---------------------------------------
# ***** VPNIP *****
POWERLEVEL9K_VPNIP_DEFAULT_BACKGROUND='black'
POWERLEVEL9K_VPNIP_DEFAULT_FOREGROUND='green1'

# ***** TryHarder *****
POWERLEVEL9K_TRYHARDER_DEFAULT_BACKGROUND='black'
POWERLEVEL9K_TRYHARDER_DEFAULT_FOREGROUND='green1'

# ***** os_icon *****
POWERLEVEL9K_OS_ICON_BACKGROUND="black"
POWERLEVEL9K_OS_ICON_FOREGROUND="green1"
POWERLEVEL9K_OS_ICON_VISUAL_IDENTIFIER_COLOR="green1"

# ***** DIR *****
POWERLEVEL9K_SHORTEN_DIR_LENGTH=4
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_beginning"

POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='green1'
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='black'
POWERLEVEL9K_DIR_DEFAULT_VISUAL_IDENTIFIER_COLOR="black"

POWERLEVEL9K_DIR_HOME_BACKGROUND="black"
POWERLEVEL9K_DIR_HOME_FOREGROUND="green1"
POWERLEVEL9K_DIR_HOME_VISUAL_IDENTIFIER_COLOR="green1"

POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="green1"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="black"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_VISUAL_IDENTIFIER_COLOR="black"

# ***** RVM *****
POWERLEVEL9K_RVM_BACKGROUND="black"
POWERLEVEL9K_RVM_FOREGROUND="249"
POWERLEVEL9K_RVM_VISUAL_IDENTIFIER_COLOR="red"

# ***** Time *****
POWERLEVEL9K_TIME_BACKGROUND="black"
POWERLEVEL9K_TIME_FOREGROUND="green1"
POWERLEVEL9K_TIME_FORMAT="%D{\UF133 %m.%d.%y}-%@"

# ***** VCS *****
# Git status - White Means its GTG
POWERLEVEL9K_VCS_CLEAN_FOREGROUND='black'
POWERLEVEL9K_VCS_CLEAN_BACKGROUND='white'
POWERLEVEL9K_VCS_CLEAN_VISUAL_IDENTIFIER_COLOR="black"

# Git status - Orange means its untracked
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='black'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='orange'
POWERLEVEL9K_VCS_UNTRACKED_IDENTIFIER_COLOR="black"

# Git status - Yellow means it was modified and needs to be checked in
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='black'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='yellow'
POWERLEVEL9K_VCS_MODIFIED_IDENTIFIER_COLOR="black"

POWERLEVEL9K_VCS_HIDE_TAGS='false'

# ***** VCS Icons *****
#POWERLEVEL9K_VCS_UNTRACKED_ICON='\u25CF'
#POWERLEVEL9K_VCS_UNSTAGED_ICON='\u00b1'
#POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON='\u2193'
#POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON='\u2191'
#POWERLEVEL9K_VCS_COMMIT_ICON="\uf417"

# ***** Command Execution Time *****
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='black'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='white'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0

# ***** Context *****
# Is the current user
POWERLEVEL9K_CONTEXT_TEMPLATE="%n💀%m"
POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND='black'
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND='green1'

# ***** Prompt *****
# Prompt line, the arrow that goes from the first to second line
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=false
POWERLEVEL9K_RPROMPT_ON_NEWLINE=true

POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{46}\u256D\u2500%f"
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{46}└─▶ "

# ***** Battery *****
POWERLEVEL9K_BATTERY_STAGES=(
   $'▏    ▏' $'▎    ▏' $'▍    ▏' $'▌    ▏' $'▋    ▏' $'▊    ▏' $'▉    ▏' $'█    ▏'
   $'█▏   ▏' $'█▎   ▏' $'█▍   ▏' $'█▌   ▏' $'█▋   ▏' $'█▊   ▏' $'█▉   ▏' $'██   ▏'
   $'██   ▏' $'██▎  ▏' $'██▍  ▏' $'██▌  ▏' $'██▋  ▏' $'██▊  ▏' $'██▉  ▏' $'███  ▏'
   $'███  ▏' $'███▎ ▏' $'███▍ ▏' $'███▌ ▏' $'███▋ ▏' $'███▊ ▏' $'███▉ ▏' $'████ ▏'
   $'████ ▏' $'████▎▏' $'████▍▏' $'████▌▏' $'████▋▏' $'████▊▏' $'████▉▏' $'█████▏' )

POWERLEVEL9K_BATTERY_LEVEL_FOREGROUND=(red3 darkorange3 darkgoldenrod gold3 yellow3 chartreuse2 mediumspringgreen green3 green3 green4 green1)
POWERLEVEL9K_BATTERY_LEVEL_BACKGROUND='black'

# ***** STATUS *****
# Return status on the left, turns red if an error
POWERLEVEL9K_STATUS_VERBOSE=true
POWERLEVEL9K_STATUS_OK_IN_NON_VERBOSE=true

POWERLEVEL9K_STATUS_ERROR_BACKGROUND="red"
POWERLEVEL9K_STATUS_ERROR_FOREGROUND="black"
#POWERLEVEL9K_STATUS_ERROR_VISUAL_IDENTIFIER_COLOR="⨯"

POWERLEVEL9K_STATUS_OK_BACKGROUND="green1"						
POWERLEVEL9K_STATUS_OK_FOREGROUND="black"						
POWERLEVEL9K_STATUS_OK_VISUAL_IDENTIFIER_COLOR=""

# ***** Other *****
POWERLEVEL9K_FOLDER_ICON=''
DISABLE_UPDATE_PROMPT=true

# ***** Command Line Display Prompts *****
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(tryHarder root_indicator dir dir_writable vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status vpnip ip context time battery)
# ---------------------------------------


# ***** Setup Plugins *****
# ---------------------------------------
# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git
         dnf
         zsh-syntax-highlighting
         zsh-autosuggestions
         k
         vscode
         colored-man-pages)
# ---------------------------------------


# ***** Setup History *****
# ---------------------------------------
# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
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
# ---------------------------------------

# configure `time` format
TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'


# ***** Sources ZSH *****
# ---------------------------------------
source "$ZSH/oh-my-zsh.sh"


# ***** User configuration *****
# ---------------------------------------

# ***** Setup Aliases *****
# ---------------------------------------
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# some more ls aliases
alias ll='k'
alias la='k -A'
alias l='ls -CF'
alias his='history'

# force zsh to show the complete history
alias history="history 0"
# ---------------------------------------

export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin

# enable auto-suggestions based on the history
if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    . /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    # change suggestion color
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh