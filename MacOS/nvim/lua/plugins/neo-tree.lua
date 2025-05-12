return {
    "nvim-neo-tree/neo-tree.nvim",
    -- branch = "v3.x", -- recommended stable branch
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- for file icons
        "MunifTanjim/nui.nvim", -- UI components
    },
    opts = {
        filesystem = {
            filtered_items = {
                visible = true, -- Show filtered items
                show_hidden_count = true,
                hide_dotfiles = false, -- Show dotfiles like .env, .gitignore
                hide_gitignored = false, -- Show .gitignored files
                hide_by_name = {
                    -- Optional: add items to hide by name
                    -- ".DS_Store",
                    -- "thumbs.db",
                },
                never_show = {}, -- Absolute never-show list
            },
        },
    },
    cmd = "Neotree", -- Lazy-load on :Neotree
    keys = {
        {
            "<leader>e",
            function()
                require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
            end,
            desc = "Toggle NeoTree (cwd)",
        },
    },
}
