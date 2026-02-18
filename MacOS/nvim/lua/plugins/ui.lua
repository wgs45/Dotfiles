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

    -- ╭──────────────────────────────────────────────────────────╮
    -- │          Icons: Web Devicons (The "Pop" Factor)          │
    -- ╰──────────────────────────────────────────────────────────╯
    {
        "nvim-tree/nvim-web-devicons",
        lazy = false, -- 🚀 Set to false to ensure icons load immediately
        opts = {
            color_icons = true,
            default = true,
        },
    },

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
            event = "VeryLazy",
        },
    },

    -- ╭──────────────────────────────────────────────────────────╮
    -- │          Lualine: Optimized & Developer Focused          │
    -- ╰──────────────────────────────────────────────────────────╯
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = function()
            return {
                options = {
                    theme = "cyberdream",
                    globalstatus = true,
                    transparent = true,
                    component_separators = { left = "｜", right = "｜" },
                    section_separators = { left = "", right = "" },
                    disabled_filetypes = {
                        statusline = { "dashboard", "alpha", "starter" },
                    },
                },
                sections = {
                    lualine_a = {
                        {
                            "mode",
                            fmt = function(str)
                                return str:sub(1, 1)
                            end,
                        },
                    },
                    lualine_b = { "branch" },
                    lualine_c = {
                        -- 🛠️ Productivity: Diagnostics on the left (Default style)
                        { "diagnostics", symbols = { error = " ", warn = " ", info = " ", hint = " " } },
                        { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
                        { "filename", path = 1 },
                    },
                    lualine_x = { "diff" },
                    lualine_y = {
                        {
                            function()
                                local clients = vim.lsp.get_clients({ bufnr = 0 })
                                local lsp_name = next(clients) ~= nil and clients[1].name or "No LSP"
                                local line = vim.fn.line(".")
                                local col = vim.fn.virtcol(".")
                                return string.format("󰄛 %s │ 󰉸 %d:%d", lsp_name, line, col)
                            end,
                        },
                    },
                    lualine_z = {
                        { "progress", color = { gui = "bold" } },
                    },
                },
            }
        end,
    },
}
