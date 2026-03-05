return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown", "quarto" },
        opts = {
            debounce = 500,
            max_file_size = 1.5,
            render_modes = { "n", "c" },

            heading = {
                sign = false,
                icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
                signs = { "󰫎 " },
            },

            bullet = {
                icons = { "•", "○", "◆", "◇" },
                right_pad = 1,
            },

            latex = {
                enabled = true,
                converter = "latex2text",
                top_pad = 1,
                bottom_pad = 1,
            },

            anti_conceal = {
                enabled = true,
                ignore = { "code_background", "sign" },
            },

            pipe_table = { preset = "round", style = "full" },
            callout = {
                note = { raw = "[!NOTE]", rendered = "󰋽 Note", highlight = "RenderMarkdownInfo" },
                tip = { raw = "[!TIP]", rendered = "󰌵 Tip", highlight = "RenderMarkdownSuccess" },
                important = { raw = "[!IMPORTANT]", rendered = "󰅒 Important", highlight = "RenderMarkdownHint" },
            },
        },
    },
}
