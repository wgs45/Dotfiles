return {
    -- ⚡ Flash: Fast navigation
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {
            search = {
                multi_window = false,
                wrap = false,
                incremental = true,
            },
        },
    },

    -- 🎨 Mini.HiPatterns: Your preferred comment & color highlighter
    {
        "nvim-mini/mini.hipatterns",
        version = "*",
        event = "BufReadPre",
        opts = function()
            local hipatterns = require("mini.hipatterns")
            return {
                highlighters = {
                    -- Highlight hex colors (e.g. #abb2bf)
                    hex_color = hipatterns.gen_highlighter.hex_color(),

                    -- 📝 Improved Comment Keywords (Replacement for todo-comments)
                    fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "DiagnosticError" },
                    todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "DiagnosticInfo" },
                    hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "DiagnosticWarn" },
                    note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "DiagnosticHint" },
                },
            }
        end,
    },

    -- 🔍 Trouble: Enhanced diagnostics for refactoring
    {
        "folke/trouble.nvim",
        opts = { use_diagnostic_signs = true },
        cmd = "Trouble",
        keys = {
            { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
            { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
        },
    },

    -- 🔭 Telescope: Simplified and optimized
    {
        "telescope.nvim",
        dependencies = {
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            "nvim-telescope/telescope-file-browser.nvim",
        },
        keys = {
            {
                ";f",
                function()
                    require("telescope.builtin").find_files({ hidden = true })
                end,
                desc = "Find Files",
            },
            {
                ";r",
                function()
                    require("telescope.builtin").live_grep()
                end,
                desc = "Live Grep",
            },
            {
                "\\\\",
                function()
                    require("telescope.builtin").buffers()
                end,
                desc = "Buffers",
            },
            {
                ";;",
                function()
                    require("telescope.builtin").resume()
                end,
                desc = "Resume Search",
            },
            -- 🔋 Battery Saver: Use Snacks instead of git.nvim
            {
                "<leader>gb",
                function()
                    Snacks.git.blame_line().open()
                end,
                desc = "Git Blame",
            },
            {
                "<leader>go",
                function()
                    Snacks.gitbrowse()
                end,
                desc = "Git Browse",
            },
        },
        config = function(_, opts)
            local telescope = require("telescope")
            opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
                layout_strategy = "horizontal",
                layout_config = { prompt_position = "top" },
                sorting_strategy = "ascending",
                winblend = 0, -- Set to 0 for better performance/battery
            })
            telescope.setup(opts)
            telescope.load_extension("fzf")
            telescope.load_extension("file_browser")
        end,
    },
}
