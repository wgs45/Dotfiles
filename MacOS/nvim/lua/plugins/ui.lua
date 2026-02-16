return {
    -- ╭──────────────────────────────────────────────────────────╮
    -- │             Noice: Enhanced UI & Notifications           │
    -- ╰──────────────────────────────────────────────────────────╯
    {
        "folke/noice.nvim",
        opts = function(_, opts)
            -- Skip annoying "No information available" messages
            table.insert(opts.routes, {
                filter = { event = "notify", find = "No information available" },
                opts = { skip = true },
            })

            -- Focus-based routing (Notify-send when Neovim is not focused)
            local focused = true
            vim.api.nvim_create_autocmd({ "FocusGained", "FocusLost" }, {
                callback = function(ev)
                    focused = ev.event == "FocusGained"
                end,
            })
            table.insert(opts.routes, 1, {
                filter = {
                    cond = function()
                        return not focused
                    end,
                },
                view = "notify_send",
                opts = { stop = false },
            })

            opts.presets.lsp_doc_border = true
        end,
    },

    -- icons
    { "nvim-tree/nvim-web-devicons", lazy = true },

    -- notify
    {
        "rcarriga/nvim-notify",
        event = "VeryLazy",
        opts = {
            render = "default",
            timeout = 3000,
            stages = "fade_in_slide_out",
        },
    },

    -- ╭──────────────────────────────────────────────────────────╮
    -- │                      Mini.Animate                        │
    -- ╰──────────────────────────────────────────────────────────╯
    {
        "nvim-mini/mini.animate",
        event = "VeryLazy",
        opts = {
            scroll = { enable = false },
            cursor = { enable = true, duration = 100, easing = "linear" },
            window = {
                enable = true,
                duration = 200,
                easing = "cubic",
            },
        },
    },

    -- ╭──────────────────────────────────────────────────────────╮
    -- │          Bufferline: Tabs and Navigation                 │
    -- ╰──────────────────────────────────────────────────────────╯
    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        keys = {
            { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
            { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
        },
        opts = {
            options = {
                mode = "tabs",
                show_buffer_close_icons = false,
                show_close_icon = false,
                diagnostics = "nvim_lsp",
                always_show_bufferline = false,
                offsets = {
                    { filetype = "neo-tree", text = "Neo-tree", highlight = "Directory", text_align = "left" },
                },
            },
        },

        -- filename
        {
            "b0o/incline.nvim",
            config = function()
                require("incline").setup()
            end,
            -- Optional: Lazy load Incline
            event = "VeryLazy",
        },
    },

    -- ╭──────────────────────────────────────────────────────────╮
    -- │          Lualine: Optimized Statusline                   │
    -- ╰──────────────────────────────────────────────────────────╯
    {
        "nvim-lualine/lualine.nvim",
        opts = function(_, opts)
            opts.options = vim.tbl_deep_extend("force", opts.options or {}, {
                theme = "cyberdream",
                globalstatus = true, -- Better performance: one statusline for all windows
                component_separators = "|",
                section_separators = "",
            })
        end,
    },
}
