# shell greeting

set fish_greeting neofetch --ascii_distro arch_small 

#function fish_greeting
#    neofetch --ascii_distro arch_small
#    date  
#end
#funcsave fish_greeting

set -gx TERM xterm-256color

# theme
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always

# aliases
alias ls "ls -p -G"
# alias la "ls -A"
# alias ll "eza --long --icons --git --header --created --modified --no-user"
# alias lt "eza --tree --icons --git --long --level=2 --header --created --modified --no-user"
alias lt "eza --icons --tree --level=3 --color=always --header"
alias ll "eza --icons --color=always --long --header --no-time -o"
alias la "eza --icons --color=always --long --header --no-time -o -a"
# alias bat "bat"
alias rp "rip"
alias rpu "rip -u"
alias ff "fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"

# alias rg "rg"
# alias fd "fd"
# alias z "z"
# alias pls "pls-cli"

# aliases for tmux
alias txn "tmux neww"
alias txk "tmux kill-session"
alias txd "tmux detach"
alias txl "tmux list-sessions"

starship init fish | source

