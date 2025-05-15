return {
    -- 🏮 Tokyonight colorscheme (transparent setup)
    -- {
    --     "folke/tokyonight.nvim",
    --     opts = {
    --         style = "night",
    --         transparent = true,
    --         styles = {
    --             sidebars = "transparent",
    --             keywords = { bold = true },
    --             functions = { bold = true },
    --             floats = "transparent",
    --         },
    --         on_colors = function(colors)
    --             colors.bg_statusline = colors.none -- try "#ff00ff" to test
    --         end,
    --     },
    -- },

    {
        "folke/tokyonight.nvim",
        opts = {
            enable = false,
        },
    },

    { "catppuccin/nvim", name = "catppuccin", opts = { enable = false } },

    -- Cyberdream setup
    {
        "scottmckendry/cyberdream.nvim",
        opts = {
            lazy = false,
            variant = "default",
            priority = 1000,
            transparent = true, -- Keep transparent for a sleek look
            italic_comments = true, -- elegant italics on comments for readability
            hide_fillchars = true, -- clean UI, no fillchars clutter
            terminal_colors = true, -- consistent terminal colors
            styles = {
                sidebars = "transparent", -- Let sidebars blend in with the background
                keywords = { bold = true }, -- Bold for better readability
                functions = { bold = true }, -- Same for functions
                floats = "transparent", -- Transparency for floating windows too
                comments = { italic = true }, -- emphasize comments with italics
            },
            -- tweak some colors for contrast and custom feel
            on_colors = function(colors)
                colors.bg_statusline = "#1e1e2e" -- slightly lighter background for statusline
                colors.bg = "#121318" -- darker bg, good for low light
                colors.selection = "#2a2c37" -- softer selection bg
            end,
        },
    },

    -- LazyVim with the TokyoNight theme
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "cyberdream", -- Set Nvim colorscheme or theme
        },
    },
}
