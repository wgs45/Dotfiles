-- lua/plugins/lsp.lua
return {
    -- mason (installer + registry)
    {
        "mason-org/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonUninstall" },
        opts = {
            ui = {
                check_outdated_packages_on_open = true,
            },
        },
    },

    -- mason-lspconfig: glue between mason and lspconfig
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
        -- keep it lazy; mason-lspconfig will only be used when lsp servers are ensured
        opts = {},
    },

    -- nvim-lspconfig (actual server setups)
    {
        "neovim/nvim-lspconfig",
        -- load later to avoid startup-order problems
        event = "VeryLazy",
        dependencies = {
            { "mason-org/mason.nvim", cmd = "Mason", config = false },
            { "mason-org/mason-lspconfig.nvim", config = false },
            { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "neovim/nvim-lspconfig" } },
            -- optional: cmp integration if installed
            { "hrsh7th/cmp-nvim-lsp", optional = true },
        },
        opts = {
            diagnostics = {
                underline = true,
                update_in_insert = false,
                virtual_text = {
                    spacing = 4,
                    source = "if_many",
                    prefix = "●",
                },
                severity_sort = true,
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
                        [vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
                        [vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
                        [vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
                    },
                },
            },
            inlay_hints = { enabled = false },
            codelens = { enabled = false },
            capabilities = {},
            format = {
                formatting_options = nil,
                timeout_ms = nil,
            },

            -- servers you want configured by default
            servers = {
                pylsp = {
                    pylsp = {
                        plugins = {
                            pycodestyle = {
                                ignore = { "W391" },
                                maxLineLength = 150,
                            },
                        },
                    },
                },
                clangd = {},
                cssls = {},
                html = {},
                lua_ls = {
                    settings = {
                        Lua = {
                            workspace = { checkThirdParty = false },
                            codeLens = { enable = true },
                            completion = { callSnippet = "Replace" },
                        },
                    },
                },
            },

            -- custom per-server setup handlers
            setup = {
                -- example: override tsserver with typescript.nvim if you use it
                -- tsserver = function(_, opts)
                --   require("typescript").setup({ server = opts })
                --   return true
                -- end,
            },
        },

        config = function(_, opts)
            -- optional: neoconf integration
            if LazyVim.has("neoconf.nvim") then
                local plugin = require("lazy.core.config").spec.plugins["neoconf.nvim"]
                require("neoconf").setup(require("lazy.core.plugin").values(plugin, "opts", false))
            end

            -- register formatters
            LazyVim.format.register(LazyVim.lsp.formatter())

            Snacks.util.lsp.on(function(client, buffer)
                require("lazyvim.plugins.lsp.keymaps").set(client, buffer)
            end)

            local register_capability = vim.lsp.handlers["client/registerCapability"]
            vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
                local ret = register_capability(err, res, ctx)
                local client = vim.lsp.get_client_by_id(ctx.client_id)
                local buffer = vim.api.nvim_get_current_buf()
                require("lazyvim.plugins.lsp.keymaps").set(client, buffer)
                return ret
            end

            -- diagnostics signs for older Neovim versions
            if vim.fn.has("nvim-0.10.0") == 0 then
                for severity, icon in pairs(opts.diagnostics.signs.text) do
                    local name = vim.diagnostic.severity[severity]:lower():gsub("^%l", string.upper)
                    name = "DiagnosticSign" .. name
                    vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
                end
            end

            -- inlay hints
            if opts.inlay_hints.enabled then
                Snacks.util.lsp.on(function(client, buffer)
                    if client.supports_method("textDocument/inlayHint") then
                        LazyVim.toggle.inlay_hints(buffer, true)
                    end
                end)
            end

            -- codelens
            if opts.codelens.enabled and vim.lsp.codelens then
                Snacks.util.lsp.on(function(client, buffer)
                    if client.supports_method("textDocument/codeLens") then
                        vim.lsp.codelens.refresh()
                        vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                            buffer = buffer,
                            callback = vim.lsp.codelens.refresh,
                        })
                    end
                end)
            end

            -- allow icon prefix function on newer Neovim builds
            if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
                opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
                    or function(diagnostic)
                        local icons = require("lazyvim.config").icons.diagnostics
                        for d, icon in pairs(icons) do
                            if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
                                return icon
                            end
                        end
                    end
            end

            vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

            -- build capabilities (include cmp integration if installed)
            local servers = opts.servers
            local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                has_cmp and cmp_nvim_lsp.default_capabilities() or {},
                opts.capabilities or {}
            )

            local function setup(server)
                local server_opts =
                    vim.tbl_deep_extend("force", { capabilities = vim.deepcopy(capabilities) }, servers[server] or {})
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

            -- determine mason-available servers and ensure installed when appropriate
            -- local have_mason, mlsp = pcall(require, "mason-lspconfig")
            -- local all_mslp_servers = {}
            -- if have_mason then
            --     all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package or {})
            -- end
            --
            -- local ensure_installed = {}
            local mason_lspconfig = require("mason-lspconfig")
            mason_lspconfig.setup({
                ensure_installed = { "lua_ls", "ts_ls", "tailwindcss", "html", "cssls" },
            })

            -- ignore non-LSP tools like stylua or shfmt
            local lsp_only_filter = function(name)
                -- return not vim.tbl_contains({ "stylua", "selene", "luacheck", "shellcheck", "shfmt" }, name)
                return false
            end

            for server, server_opts in pairs(servers) do
                if server ~= "*" then
                    setup(server)
                end -- skip invalid server name
                if lsp_only_filter(server) and server_opts then
                    server_opts = server_opts == true and {} or server_opts
                    if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
                        setup(server)
                    elseif server_opts.enabled ~= false then
                        ensure_installed[#ensure_installed + 1] = server
                    end
                end
            end

            if have_mason then
                mlsp.setup({
                    ensure_installed = vim.tbl_deep_extend(
                        "force",
                        ensure_installed,
                        LazyVim.opts("mason-lspconfig.nvim").ensure_installed or {}
                    ),
                    handlers = { setup },
                })
            end
        end,
    },
}
