-- ╭──────────────────────────────────────────────────────────╮
-- │                  AutoCmd Scroll                          │
-- ╰──────────────────────────────────────────────────────────╯

local autocmd = vim.api.nvim_create_autocmd

-- ── Behavior ────────────────────────────────────────────────

-- Exit paste mode automatically when leaving insert mode
autocmd("InsertLeave", {
    pattern = "*",
    command = "set nopaste",
})

-- ── UI ──────────────────────────────────────────────────────

-- Disable conceal in specific filetypes (for readability!)
autocmd("FileType", {
    pattern = { "json", "jsonc", "markdown" },
    callback = function()
        vim.opt.conceallevel = 0
    end,
})

-- ── Spell Check ─────────────────────────────────────────────

-- Enable spell checking in prose files (Markdown, commits, etc.)
autocmd("FileType", {
    pattern = { "markdown", "gitcommit", "text" },
    callback = function()
        vim.opt.spell = true
        vim.opt.spelllang = { "en_us" }
    end,
})

-- ── Yank ─────────────────────────────────────

-- Highlight on yank (nice visual feedback!)
autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({ timeout = 200 })
    end,
})
