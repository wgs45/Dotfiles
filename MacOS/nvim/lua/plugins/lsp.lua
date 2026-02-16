return {
    -- mason (installer + registry)
    {
        "mason-org/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonUninstall" },
        opts = {
            ui = { check_outdated_packages_on_open = true },
        },
    },

    -- mason-lspconfig: bridge between mason and lspconfig
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
        opts = {
            ensure_installed = { "lua_ls", "ts_ls", "tailwindcss", "html", "cssls", "pylsp" },
        },
    },

    -- nvim-lspconfig (actual server setups)
    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
        dependencies = {
            { "mason-org/mason.nvim" },
            { "mason-org/mason-lspconfig.nvim" },
            { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "neovim/nvim-lspconfig" } },
            { "hrsh7th/cmp-nvim-lsp", optional = true },
        },
        opts = {
            diagnostics = {
                underline = true,
                update_in_insert = false,
                virtual_text = { spacing = 4, source = "if_many", prefix = "●" },
                severity_sort = true,
            },
            inlay_hints = { enabled = false },
            codelens = { enabled = false },
            servers = {
                pylsp = {
                    settings = {
                        pylsp = {
                            plugins = {
                                pycodestyle = { ignore = { "W391" }, maxLineLength = 150 },
                            },
                        },
                    },
                },
                clangd = {},
                cssls = {},
                html = {},
                ts_ls = {},
                lua_ls = {
                    settings = {
                        Lua = {
                            workspace = { checkThirdParty = false },
                            completion = { callSnippet = "Replace" },
                        },
                    },
                },
            },
            setup = {},
        },

        config = function(_, opts)
            -- 1. Setup diagnostics
            vim.diagnostic.config(opts.diagnostics)

            -- 2. Build capabilities for nvim-cmp integration
            local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                has_cmp and cmp_nvim_lsp.default_capabilities() or {},
                opts.capabilities or {}
            )

            -- 3. Define the setup function
            local function setup(server)
                local server_opts = vim.tbl_deep_extend("force", {
                    capabilities = vim.deepcopy(capabilities),
                }, opts.servers[server] or {})

                -- Run custom setup handlers if defined in opts.setup
                if opts.setup[server] then
                    if opts.setup[server](server, server_opts) then
                        return
                    end
                elseif opts.setup["*"] then
                    if opts.setup["*"](server, server_opts) then
                        return
                    end
                end

                require("lspconfig")[server].setup(server_opts)
            end

            -- 4. Initialize mason-lspconfig with handlers
            local mlsp = require("mason-lspconfig")
            mlsp.setup({
                ensure_installed = opts.ensure_installed,
                handlers = { setup }, -- Automatically calls our setup function for installed servers
            })

            -- 5. Manually setup servers NOT managed by Mason
            for server, _ in pairs(opts.servers) do
                if server ~= "*" and not vim.tbl_contains(mlsp.get_installed_servers(), server) then
                    setup(server)
                end
            end
        end,
    },
}
