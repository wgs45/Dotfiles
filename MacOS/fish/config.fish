# 🚀 Environment Variables
# Ensure TERM is set correctly for Kitty's advanced features (like images)
set -gx TERM xterm-kitty
set -gx EDITOR nvim
set -gx STARSHIP_CONFIG ~/.config/starship/starship.toml

starship init fish | source
zoxide init fish | source

# ⚡ Abbreviations (Productivity - Expands on Space)
# File Listing (using eza)
abbr -a la "eza -all --long --links --icons --group --git --header --created --modified --no-user -o"
abbr -a ll "eza --long --icons --links --group --git --header --created --modified --no-user -o"
abbr -a lt "eza --tree --icons --group --git --long --level=2 --header --created --modified --no-user -o"

# Utilities
abbr -a bat 'bat --color=always'
abbr -a ff "fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
abbr -a vim nvim
abbr -a pn pnpm
abbr -a ss snitch

# Git (High Productivity)
abbr -a g git
abbr -a ga 'git add'
abbr -a gc 'git commit -m'
abbr -a gp 'git push'
abbr -a gst 'git status'

# DB alias (Multiple Databases)
abbr -a run-mongodb "brew services start mongodb-community"
abbr -a run-mysql "brew services start mysql"
abbr -a run-pgsql "brew services start postgresql@18"
abbr -a db-status "brew services list"
# Stop all dataabases at once
abbr -a db-stop "brew services stop mysql && brew services stop postgresql@14 && brew services stop mongodb-community"

# Trash replacement (rip)
abbr -a rp rip
abbr -a rpu 'rip -u'

# Android SDK & Java
set -gx ANDROID_HOME $HOME/Library/Android/sdk
set -gx JAVA_HOME "/Applications/Android Studio.app/Contents/jbr/Contents/Home"

# Add tools to PATH
fish_add_path $JAVA_HOME/bin
fish_add_path $ANDROID_HOME/emulator
fish_add_path $ANDROID_HOME/platform-tools
fish_add_path $ANDROID_HOME/cmdline-tools/latest/bin

# Transient Prompt
# This keeps terminal history extremely clean.
# It hides the heavy Starship prompt on old lines.
function starship_transient_prompt_func
    starship module character
end
