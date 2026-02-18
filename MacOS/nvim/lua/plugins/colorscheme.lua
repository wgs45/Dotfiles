return {
    -- 🌌 Cyberdream: High-performance, high-contrast theme
    {
        "scottmckendry/cyberdream.nvim",
        lazy = false, -- Moved out of opts for faster startup
        priority = 1000, -- Ensures theme loads before other plugins
        opts = {
            transparent = true,
            italic_comments = true,
            hide_fillchars = true,
            terminal_colors = true,
            styles = {
                sidebars = "transparent",
                floats = "transparent",
                keywords = { bold = true },
                functions = { bold = true },
            },
            on_colors = function(colors)
                colors.bg = "#121318"
                colors.bg_statusline = "#1e1e2e"
                colors.selection = "#3c4048"
            end,
        },
    },

    -- ⚙️ LazyVim Integration
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "cyberdream",
        },
    },
}
