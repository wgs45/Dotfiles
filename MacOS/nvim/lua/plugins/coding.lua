return {
    -- ✍️ Neogen: Fast Doc Annotations
    {
        "danymat/neogen",
        keys = {
            {
                "<leader>cc",
                function()
                    require("neogen").generate({})
                end,
                desc = "Neogen Comment",
            },
        },
        opts = { snippet_engine = "luasnip" },
    },

    -- ⚡ Blink.cmp: The high-performance completion choice
    {
        "saghen/blink.cmp",
        opts = {
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
                per_filetype = { sql = { "snippets", "dadbod", "buffer" } },
                providers = {
                    dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
                },
            },
        },
    },

    { "smjonas/inc-rename.nvim", cmd = "IncRename", config = true },
    {
        "ThePrimeagen/refactoring.nvim",
        keys = {
            {
                "<leader>r",
                function()
                    require("refactoring").select_refactor()
                end,
                mode = "v",
                desc = "Refactor",
            },
        },
        opts = {},
    },

    -- 🔄 Dial: Better increment/decrement (dates, hex, etc.)
    {
        "monaqa/dial.nvim",
        keys = {
            {
                "<C-a>",
                function()
                    return require("dial.map").inc_normal()
                end,
                expr = true,
                desc = "Increment",
            },
            {
                "<C-x>",
                function()
                    return require("dial.map").dec_normal()
                end,
                expr = true,
                desc = "Decrement",
            },
        },
        config = function()
            local augend = require("dial.augend")
            require("dial.config").augends:register_group({
                default = {
                    augend.integer.alias.decimal,
                    augend.integer.alias.hex,
                    augend.date.alias["%Y/%m/%d"],
                    augend.constant.alias.bool,
                    augend.semver.alias.semver,
                    augend.constant.new({ elements = { "let", "const" } }),
                },
            })
        end,
    },

    -- 🪵 Autopairs & Formatting
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = { check_ts = true, ignored_next_char = "[%w%.]" },
    },
    {
        "stevearc/conform.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "black", "isort" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                ["*"] = { "trim_whitespace" },
            },
        },
    },

    -- 🗄️ Database Tools
    {
        "kristijanhusak/vim-dadbod-ui",
        dependencies = {
            { "tpope/vim-dadbod", lazy = true },
            { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
        },
        cmd = { "DBUI", "DBUIToggle" },
        init = function()
            vim.g.db_ui_use_nerd_fonts = 1
        end,
    },
}
