return {
    -- messages, cmdline and the popupmenu
    {
        "folke/noice.nvim",
        opts = function(_, opts)
            table.insert(opts.routes, {
                filter = {
                    event = "notify",
                    find = "No information available",
                },
                opts = { skip = true },
            })
            local focused = true
            vim.api.nvim_create_autocmd("FocusGained", {
                callback = function()
                    focused = true
                end,
            })
            vim.api.nvim_create_autocmd("FocusLost", {
                callback = function()
                    focused = false
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

            opts.commands = {
                all = {
                    -- options for the message history that you get with `:Noice`
                    view = "split",
                    opts = { enter = true, format = "details" },
                    filter = {},
                },
            }

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "markdown",
                callback = function(event)
                    vim.schedule(function()
                        require("noice.text.markdown").keys(event.buf)
                    end)
                end,
            })

            opts.presets.lsp_doc_border = true
        end,
    },

    -- icons
    { "nvim-tree/nvim-web-devicons", lazy = true },

    -- notify
    {
        "rcarriga/nvim-notify",
        opts = {
            timeout = 3000,
        },
    },

    -- animations
    {
        "echasnovski/mini.animate",
        event = "VeryLazy",
        opts = function(_, opts)
            opts.scroll = {
                enable = false,
            }
            opts.window = {
                enable = true, -- Enable window animations (for opening/closing windows).
                duration = 200, -- Set the duration for window animations (in milliseconds).
                easing = "cubic", -- Use cubic easing for smoother transitions.
            }
            opts.cursor = {
                enable = true, -- Enable cursor animations (optional, can enhance interactivity).
                duration = 150, -- Cursor animation speed (lower value = faster animation).
                easing = "linear", -- Keep cursor animations sharp and quick.
            }
            opts.highlight = {
                enable = true, -- Enable highlighting animations (such as on search results).
                duration = 150, -- Duration for highlight animations.
            }
            opts.background = {
                enable = true, -- Allow background animations for transitions.
                duration = 300, -- Background fade duration for smooth transitions.
            }
        end,
    },

    -- logo
    {
        "nvimdev/dashboard-nvim",
        enabled = false,
        event = "VimEnter",
    },

    -- buffer line
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
                -- separator_style = "slant",
                show_buffer_close_icons = false,
                show_close_icon = false,
                 -- stylua: ignore
                close_command = function(n) require("mini.bufremove").delete(n, false) end,
                -- stylua: ignore
                right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
                diagnostics = "nvim_lsp",
                always_show_bufferline = false,
                diagnostics_indicator = function(_, _, diag)
                    local icons = require("lazyvim.config").icons.diagnostics
                    local ret = (diag.error and icons.Error .. diag.error .. " " or "")
                        .. (diag.warning and icons.Warn .. diag.warning or "")
                    return vim.trim(ret)
                end,
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "Neo-tree",
                        highlight = "Directory",
                        text_align = "left",
                    },
                },
            },
        },
        config = function(_, opts)
            require("bufferline").setup(opts)
            -- Fix bufferline when restoring a session
            vim.api.nvim_create_autocmd("BufAdd", {
                callback = function()
                    vim.schedule(function()
                        pcall(nvim_bufferline)
                    end)
                end,
            })
        end,

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

    -- 🎵 Lualine: statusline setup with Tokyonight theme
    {
        "nvim-lualine/lualine.nvim",
        opts = function(_, opts)
            opts.options = {
                theme = "cyberdream",
                component_separators = "|",
                section_separators = "",
                globalstatus = true,
                disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
            }
        end,
    },
}
