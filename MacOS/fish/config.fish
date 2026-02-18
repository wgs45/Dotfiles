# 🚀 Environment Variables
# Ensure TERM is set correctly for Kitty's advanced features (like images)
set -gx TERM xterm-kitty
set -gx EDITOR nvim

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

# Trash replacement (rip)
abbr -a rp rip
abbr -a rpu 'rip -u'

# 🔋 Battery Tip: Transient Prompt
# This keeps your terminal history extremely clean.
# It hides the heavy Starship prompt on old lines.
function starship_transient_prompt_func
    starship module character
end
