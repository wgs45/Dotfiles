-- ╭──────────────────────────────────────────────────────────╮
-- │                   Keymap Grimoire                        │
-- ╰──────────────────────────────────────────────────────────╯

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- ✨ General Keymaps
keymap.set("n", "x", '"_x') -- Delete without affecting registers
keymap.set("n", "<Leader>p", '"0p') -- Paste from clipboard
keymap.set("n", "<Leader>P", '"0P') -- Paste above without affecting registers
keymap.set("v", "<Leader>p", '"0p') -- Paste in visual mode
keymap.set("n", "<Leader>c", '"_c') -- Change without affecting registers
keymap.set("n", "<Leader>C", '"_C') -- Change without affecting registers
keymap.set("v", "<Leader>c", '"_c') -- Change in visual mode
keymap.set("v", "<Leader>C", '"_C') -- Change in visual mode

-- ✨ Increment/Decrement
keymap.set("n", "+", "<C-a>") -- Increment number
keymap.set("n", "-", "<C-x>") -- Decrement number

-- ✨ Delete a word backwards (without affecting the register)
keymap.set("n", "dw", 'vb"_d')

-- ✨ Select all (for a fresh start!)
keymap.set("n", "<C-a>", "gg<S-v>G")

-- ✨ Save with root permission (if you desire!)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- ✨ Disable continuations (quick line start)
keymap.set("n", "<Leader>o", "o<Esc>^Da", opts)
keymap.set("n", "<Leader>O", "O<Esc>^Da", opts)

-- ✨ Jump to the next item in the jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- ✨ Tabs & Splits: Navigate and Create
keymap.set("n", "te", ":tabedit") -- Open new tab
keymap.set("n", "<tab>", ":tabnext<Return>", opts) -- Go to next tab
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts) -- Go to previous tab
keymap.set("n", "ss", ":split<Return>", opts) -- Horizontal split
keymap.set("n", "sv", ":vsplit<Return>", opts) -- Vertical split

-- ✨ Move between windows with ease
keymap.set("n", "sh", "<C-w>h") -- Move to the left window
keymap.set("n", "sk", "<C-w>k") -- Move to the upper window
keymap.set("n", "sj", "<C-w>j") -- Move to the lower window
keymap.set("n", "sl", "<C-w>l") -- Move to the right window

-- ✨ Resize windows for precision
keymap.set("n", "<C-w><left>", "<C-w><") -- Decrease width
keymap.set("n", "<C-w><right>", "<C-w>>") -- Increase width
keymap.set("n", "<C-w><up>", "<C-w>+") -- Increase height
keymap.set("n", "<C-w><down>", "<C-w>-") -- Decrease height

-- ✨ Bonus: Jumping in files like a magical breeze~
keymap.set("n", "<Leader>j", ":Telescope find_files<CR>", opts) -- Find files with Telescope


