local function augroup(name)
    return vim.api.nvim_create_augroup("magical_" .. name, { clear = true })
end

-- ── Behavior ────────────────────────────────────────────────

-- ✨ Productivity: Auto-resize splits when the terminal window is resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
    group = augroup("resize_splits"),
    callback = function()
        local current_tab = vim.api.nvim_get_current_tabpage()
        vim.cmd("tabdo wincmd =")
        vim.api.nvim_set_current_tabpage(current_tab)
    end,
})

-- Exit paste mode automatically when leaving insert mode
vim.api.nvim_create_autocmd("InsertLeave", {
    group = augroup("nopaste"),
    pattern = "*",
    command = "set nopaste",
})

-- ── UI & Readability ────────────────────────────────────────

-- Disable conceal in specific filetypes
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("conceal_settings"),
    pattern = { "json", "jsonc", "markdown" },
    callback = function()
        vim.opt_local.conceallevel = 0
    end,
})

-- Enable spell checking in prose files
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("prose_settings"),
    pattern = { "markdown", "gitcommit", "text" },
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.spelllang = { "en_us" }
    end,
})

-- ✨ Productivity: Go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
    group = augroup("last_loc"),
    callback = function(event)
        local exclude = { "gitcommit" }
        local buf = event.buf
        if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
            return
        end
        vim.b[buf].lazyvim_last_loc = true
        local mark = vim.api.nvim_buf_get_mark(buf, '"')
        local lcount = vim.api.nvim_buf_line_count(buf)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})
