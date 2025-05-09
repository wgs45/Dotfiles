-- ╭──────────────────────────────────────────────────────────╮
-- │                  Magical Options                         │
-- ╰──────────────────────────────────────────────────────────╯

local opt = vim.opt

-- ✨ UI Enhancements
opt.number = true -- Show absolute line numbers
opt.relativenumber = false -- Disable relative numbers
opt.cursorline = false -- No highlight on the current line
opt.signcolumn = "yes" -- Show signs inside line number column (try "yes" if you prefer)
opt.title = true -- Set terminal title
opt.cmdheight = 1 -- Minimal command line height
opt.laststatus = 2 -- Global statusline
opt.scrolloff = 10 -- Keep cursor from touching top/bottom
opt.sidescrolloff = 8 -- Same for horizontal movement
opt.wrap = true -- Enable soft wrap (for prose, markdown, etc.)
opt.breakindent = true -- Preserve indentation when wrapping

-- ✨ Visual Aesthetics
opt.termguicolors = true -- Enable true color (Kitty supports it!)
opt.signcolumn = "number" -- Show LSP & git signs in number column
opt.iskeyword:append("-") -- Treat dash-separated words as one

-- ✨ Encoding
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- ✨ Search
opt.hlsearch = true -- Highlight search results
opt.ignorecase = true -- Case-insensitive by default
opt.smartcase = true -- Smart case-sensitive when uppercase used

-- ✨ Indentation
opt.tabstop = 4 -- Tab width
opt.shiftwidth = 4 -- Auto-indent width
opt.expandtab = true -- Tabs become spaces
opt.autoindent = true
opt.smartindent = true
opt.smarttab = true

-- ✨ Shell & Commands
opt.shell = "fish" -- Your magical shell
opt.inccommand = "split" -- Preview substitution live

-- ✨ Path & Ignore
opt.path:append("**") -- Recursive file search
opt.wildignore:append({ "*/node_modules/*" })

-- ✨ Clipboard & Backspace
opt.clipboard:append("unnamedplus") -- Use system clipboard
opt.backspace = { "start", "eol", "indent" }

-- ✨ Splits
opt.splitright = true
opt.splitbelow = true
opt.splitkeep = "cursor"

-- ✨ Undercurl (Kitty supports this!)
vim.cmd([[let &t_Cs = "\e[4:3m"]]) -- Start undercurl
vim.cmd([[let &t_Ce = "\e[4:0m"]]) -- End undercurl

-- ✨ Diagnostic Settings (Optional but recommended)
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})
