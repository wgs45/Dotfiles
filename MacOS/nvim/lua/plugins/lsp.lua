return {
    -- mason (installer + registry)
    {
        "mason-org/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonUninstall" },
        opts = {
            ui = {
                border = "rounded",
                check_outdated_packages_on_open = false, -- 🔋 Battery: Check for updates manually
            },
        },
    },

    -- nvim-lspconfig
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" }, -- 🚀 Perf: Load only when opening code
        dependencies = {
            "mason-org/mason.nvim",
            "mason-org/mason-lspconfig.nvim",
            { "folke/neoconf.nvim", cmd = "Neoconf", config = false },
        },
        opts = {
            ensure_installed = { "lua_ls", "ts_ls", "tailwindcss", "html", "cssls", "pylsp" },
            servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            diagnostics = { globals = { "vim" } },
                            workspace = { checkThirdParty = false },
                            telemetry = { enable = false },
                        },
                    },
                },
                marksman = {},
                texlab = {},
                ts_ls = {},
                pylsp = {},
                tailwindcss = {},
                html = {},
                cssls = {},
            },
            -- 🎨 Diagnostic UI
            diagnostics = {
                underline = true,
                update_in_insert = false, -- 🔋 Battery: Don't re-scan while typing
                virtual_text = {
                    spacing = 4,
                    prefix = "●",
                },
                severity_sort = true,
            },
        },
        config = function(_, opts)
            local mlsp = require("mason-lspconfig")
            local lspconfig = require("lspconfig")
            local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

            -- Setup common capabilities for completion
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                has_cmp and cmp_nvim_lsp.default_capabilities() or {},
                opts.capabilities or {}
            )

            local signs = { Error = " ", Warn = " ", Info = " ", Hint = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            end

            vim.diagnostic.config(opts.diagnostics)

            -- ⌨️ Productivity: Setup Keymaps when LSP attaches
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local bufnr = args.buf
                    local map = function(keys, func, desc)
                        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
                    end

                    map("gd", vim.lsp.buf.definition, "Goto Definition")
                    map("gr", vim.lsp.buf.references, "Goto References")
                    map("K", vim.lsp.buf.hover, "Hover Documentation")
                    map("<leader>cr", vim.lsp.buf.rename, "Rename Symbol")
                    map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
                end,
            })

            mlsp.setup({
                ensure_installed = opts.ensure_installed,
                handlers = {
                    function(server_name)
                        local server_opts = vim.tbl_deep_extend("force", {
                            capabilities = vim.deepcopy(capabilities),
                        }, opts.servers[server_name] or {})

                        lspconfig[server_name].setup(server_opts)
                    end,
                },
            })
        end,
    },
}
