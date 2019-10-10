# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/ss/.oh-my-zsh"
# neofetch

ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_MODE='nerdfont-complete'
# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# export ALL_PROXY=socks5://127.0.0.1:1080

# Prompt settings
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
# POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%K{green}%F{black} \uf303  %f%F{green}%k\ue0b0%f"

# Separators
POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=$'\ue0b0' # 
POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=$'\ue0b1' # 
POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=$'\ue0b2' # 
POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR=$'\ue0b3'  # 

# Dir colours
POWERLEVEL9K_DIR_HOME_BACKGROUND='black'
POWERLEVEL9K_DIR_HOME_FOREGROUND='white'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='black'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='white'
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='yellow'
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='black'
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"

# OS segment
POWERLEVEL9K_OS_ICON_BACKGROUND='black'
POWERLEVEL9K_LINUX_ICON='\uf303' # 


# VCS icons
POWERLEVEL9K_VCS_GIT_ICON=$'\uf1d3' #  
POWERLEVEL9K_VCS_GIT_GITHUB_ICON=$'\uf113' # 
POWERLEVEL9K_VCS_GIT_GITLAB_ICON=$'\uf296' # 
POWERLEVEL9K_VCS_BRANCH_ICON=$''
POWERLEVEL9K_VCS_STAGED_ICON=$'\uf055' # 
POWERLEVEL9K_VCS_UNSTAGED_ICON=$'\uf421' # 
POWERLEVEL9K_VCS_UNTRACKED_ICON=$'\uf00d' # 
POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON=$'\uf0ab' # 
POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON=$'\uf0aa' # 

# VCS colours
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='blue'
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='black'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='green'
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='black'
POWERLEVEL9K_VCS_CLEAN_BACKGROUND='green'
POWERLEVEL9K_VCS_CLEAN_FOREGROUND='black'

# VCS CONFIG
POWERLEVEL9K_SHOW_CHANGESET=false

# Status
POWERLEVEL9K_OK_ICON=$'\uf00c' # 
POWERLEVEL9K_FAIL_ICON=$'\uf00d' # 
POWERLEVEL9K_CARRIAGE_RETURN_ICON=$'\uf00d' # 

# Battery
POWERLEVEL9K_BATTERY_LOW_BACKGROUND='red'
POWERLEVEL9K_BATTERY_CHARGING_BACKGROUND='purple'
POWERLEVEL9K_BATTERY_CHARGED_BACKGROUND='green'
POWERLEVEL9K_BATTERY_DISCONNECTED_BACKGROUND='purple'
POWERLEVEL9K_BATTERY_BACKGROUND="yellow"
POWERLEVEL9K_BATTERY_VERBOSE=true
POWERLEVEL9K_BATTERY_CHARGED_FOREGROUND="black"
# date
POWERLEVEL9K_DATE_FORMAT='%D{%H:%M \uf017 %y-%d-%m}'
POWERLEVEL9K_DATE_FOREGROUND='white'
POWERLEVEL9K_DATE_BACKGROUND="blue"

# user
POWERLEVEL9K_USER_ICON="\uF2c0" # 
POWERLEVEL9K_ROOT_ICON="#"
POWERLEVEL9K_SUDO_ICON=$'\uF09C' # 

# POWERLEVEL9K_KUBECONTEXT_BACKGROUND="black"
# POWERLEVEL9K_KUBECONTEXT_FOREGROUND="green"

# zsh_wifi_signal(){
#     local signal=$(nmcli device wifi | grep '*' | awk '{print $7}')
#     local color='%F{yellow}'
#     [[ $signal -gt 75 ]] && color='%F{green}'
#     [[ $signal -lt 50 ]] && color='%F{blue}'
#     [[ $signal = '' ]] && color='%F{red}'
#     echo -n "%{$color%}\uf1eb " # 
# }

POWERLEVEL9K_CUSTOM_WIFI_SIGNAL="zsh_wifi_signal"
POWERLEVEL9K_CUSTOM_WIFI_SIGNAL_BACKGROUND="black"

# Prompt elements
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(custom_wifi_signal user dir_writable dir  vcs)
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir_writable dir vcs)
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs battery date kubecontext)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs kubecontext date)
plugins=(git zsh-autosuggestions history-substring-search zsh-syntax-highlighting kubectl)

alias yyu='yay -Syyu'
alias spms='sudo pacman -S'
alias ys='yay -S'
alias spmr='sudo pacman -Rscn'
alias yr='yay -Rscn'
alias gtc='git clone'
alias la='ls -Fa'          # 列出所有文件
alias ll='ls -Fls'         # 列出文件详细信息
alias rm='rm -i'           # 删除前需确认
alias cp='cp -i'           # 覆盖前需确认
alias mv='mv -i'           # 覆盖前需确认
alias vi='vim'             # 输入 vi 命令时使用 vim 编辑器

source $ZSH/oh-my-zsh.sh
