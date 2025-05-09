return {
    -- TokyoNight theme setup
    {
        "folke/tokyonight.nvim",
        opts = {
            style = "night", -- Could also use 'storm' for a bit darker variant
            transparent = true, -- Keep transparent for a sleek look
            styles = {
                sidebars = "transparent", -- Let sidebars blend in with the background
                keywords = { bold = true }, -- Bold for better readability
                functions = { bold = true }, -- Same for functions
                floats = "transparent", -- Transparency for floating windows too
            },
            on_colors = function(colors)
                -- Set a color for the statusline for contrast
                colors.bg_statusline = "#1e1e2e" -- Light dark background for statusline
                -- Feel free to tweak this if you'd like to use a specific color!
            end,
        },
    },

    -- LazyVim with the TokyoNight theme
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "tokyonight", -- Ensure it's using TokyoNight as default theme
        },
    },
}
