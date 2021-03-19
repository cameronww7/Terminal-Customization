# ***** Path to your oh-my-zsh installation *****
# ---------------------------------------
export ZSH="/home/$USER/.oh-my-zsh"
# ---------------------------------------


# ***** Setup setopt *****
# ---------------------------------------
WORDCHARS=${WORDCHARS//\/} # Don't consider certain characters part of the word
# ---------------------------------------


# ***** Hides EOL Sign ('%') *****
# ---------------------------------------
PROMPT_EOL_MARK=""
# ---------------------------------------


# ***** Setup ZSH Base *****
# ---------------------------------------
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# Also see for status - https://gitmemory.com/issue/bhilburn/powerlevel9k/501/500341341
ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_MODE="awesome-fontconfig"
# ---------------------------------------


# ***** Setup Custom Displays *****
# ---------------------------------------
# ***** Internet Signal Display *****
prompt_zsh_internet_signal(){
  local symbol="\uf7ba"
  local strength=`iwconfig wlp5s0 | grep -i "link quality" | grep -o "[0-9]*/[0-9]*"`
  
  echo -n "%F{white}\uE0B3 $symbol $strength"
}

# ***** TryHarder Display *****
prompt_tryHarder() {
    local content='%F{46}\uF17C TryHard3r'
    $1_prompt_segment "$0" "$2" "black" "white" "$content" "#"
}
# ---------------------------------------


# ***** Setup Powerline9k *****
# ---------------------------------------
# ***** TryHarder *****
POWERLINE9K_TRYHARDER_DEFAULT_BACKGROUND='black'
POWERLINE9K_TRYHARDER_DEFAULT_FOREGROUND='green1'

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
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(tryHarder custom_internet_signal ssh root_indicator dir dir_writable vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status vpn_ip context time battery)
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
# ---------------------------------------


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
