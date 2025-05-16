return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x", -- use the latest stable branch
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
        {
            "<leader>e",
            function()
                require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
            end,
            desc = "󰙅 Toggle NeoTree (cwd)", -- Icon magic! ✨
        },
        {
            "<leader>E",
            function()
                require("neo-tree.command").execute({ toggle = true, dir = vim.fn.expand("%:p:h") })
            end,
            desc = "󰙄 Toggle NeoTree (buffer dir)",
        },
    },
    opts = {
        close_if_last_window = true, -- auto close NeoTree if it's the last window
        enable_git_status = true,
        enable_diagnostics = true,
        filesystem = {
            bind_to_cwd = true,
            follow_current_file = {
                enabled = true, -- auto focus file in tree
                leave_dirs_open = true,
            },
            filtered_items = {
                visible = true,
                show_hidden_count = true,
                hide_dotfiles = false,
                hide_gitignored = false,
                hide_by_name = {
                    ".DS_Store",
                    "thumbs.db",
                },
                never_show = {
                    ".null-ls_*",
                },
            },
            group_empty_dirs = true,
            use_libuv_file_watcher = true, -- react to file system changes
        },
        default_component_configs = {
            indent = {
                with_markers = true,
                indent_marker = "│",
                last_indent_marker = "└",
                highlight = "NeoTreeIndentMarker",
            },
            icon = {
                folder_closed = "",
                folder_open = "",
                folder_empty = "",
                default = "",
            },
            modified = {
                symbol = "",
                highlight = "NeoTreeModified",
            },
            git_status = {
                symbols = {
                    added = "✚",
                    modified = "",
                    deleted = "✖",
                    renamed = "➜",
                    untracked = "★",
                    ignored = "◌",
                    unstaged = "✗",
                    staged = "✓",
                    conflict = "",
                },
            },
        },
        window = {
            position = "left",
            width = 32,
            mappings = {
                ["<space>"] = "toggle_node",
                ["<cr>"] = "open",
                ["<esc>"] = "cancel", -- close filter input
                ["S"] = "open_split",
                ["s"] = "open_vsplit",
                ["C"] = "close_node",
                ["z"] = "close_all_nodes",
                ["R"] = "refresh",
                ["a"] = { "add", config = { show_path = "relative" } },
                ["d"] = "delete",
                ["r"] = "rename",
                ["y"] = "copy_to_clipboard",
                ["x"] = "cut_to_clipboard",
                ["p"] = "paste_from_clipboard",
                ["q"] = "close_window",
                ["?"] = "show_help",
            },
        },
    },
}
