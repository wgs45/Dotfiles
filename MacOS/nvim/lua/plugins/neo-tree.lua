return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    keys = {
        -- ✨Faster toggle
        { "<leader>e", "<cmd>Neotree toggle current reveal_force_cwd<cr>", desc = "Toggle NeoTree (cwd)" },
        { "<leader>E", "<cmd>Neotree toggle float reveal_force_cwd<cr>", desc = "Floating NeoTree" },
    },
    opts = {
        -- 🔋 Performance: Close to save memory
        close_if_last_window = true,

        -- 🛠️ Show exactly what is happening in Git/LSP
        enable_git_status = true,
        enable_diagnostics = true,

        filesystem = {
            bind_to_cwd = true,
            follow_current_file = { enabled = true },
            -- 🔋 Battery: Reacting to changes is good, but use with caution on large repos
            use_libuv_file_watcher = true,
            filtered_items = {
                visible = true, -- Productivity: See hidden files by default
                hide_dotfiles = false,
                hide_gitignored = false,
            },
        },
        default_component_configs = {
            indent = {
                with_markers = true,
                indent_marker = "│",
            },
            git_status = {
                symbols = {
                    added = "✚",
                    modified = "",
                    deleted = "✖",
                    untracked = "★",
                    ignored = "◌",
                },
            },
        },
        window = {
            width = 30,
            mappings = {
                ["<space>"] = "none", -- Clear space for leader keys
                ["l"] = "open", -- Productivity: Use HJKL to navigate tree
                ["h"] = "close_node",
                ["P"] = { "toggle_preview", config = { use_float = true } }, -- Quick peek
            },
        },
    },
}
