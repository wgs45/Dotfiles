local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
    spec = {
        -- 📦 Core & Extras
        { "LazyVim/LazyVim", import = "lazyvim.plugins" },

        -- Import extras (Optimized: only what you use)
        { import = "lazyvim.plugins.extras.linting.eslint" },
        { import = "lazyvim.plugins.extras.formatting.prettier" },
        { import = "lazyvim.plugins.extras.lang.typescript" },
        { import = "lazyvim.plugins.extras.lang.json" },
        { import = "lazyvim.plugins.extras.lang.tailwind" },
        -- { import = "lazyvim.plugins.extras.util.mini-hipatterns" }, -- Enabled via your editor.lua instead

        -- 📂 Custom Plugins
        { import = "plugins" },
    },
    defaults = {
        -- 🚀 PERF: Set to true to lazy-load all custom plugins by default
        lazy = true,
        version = false,
    },
    -- 🎨 Use your actual theme for the installer UI
    install = { colorscheme = { "cyberdream", "habamax" } },

    -- 🔋 Battery: Check for updates manually to save power
    checker = {
        enabled = false, -- Change to true only when you want to update
        notify = false,
    },

    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})
