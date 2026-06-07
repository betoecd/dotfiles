return {
    {
        "neovim/nvim-lspconfig",
        opts = function(_, opts)
            opts.servers = opts.servers or {}
            -- merge (don't replace) so LazyVim's go extra settings — notably
            -- settings.gopls.semanticTokens = true — are preserved.
            opts.servers.gopls = vim.tbl_deep_extend("force", opts.servers.gopls or {}, {
                settings = {
                    gopls = {
                        analyses = {
                            unusedparams = true,
                        },
                        staticcheck = true,
                        usePlaceholders = true,
                        completeUnimported = true, -- This enables auto-import
                        gofumpt = true,
                    },
                },
            })

            -- Override LazyVim's gopls semantic-tokens workaround with a
            -- nil-safe version. The upstream one indexes
            -- client.config.capabilities.textDocument.semanticTokens, which is
            -- nil here (capabilities come from blink.cmp) and crashes go.lua:64.
            opts.setup = opts.setup or {}
            opts.setup.gopls = function(_, _)
                Snacks.util.lsp.on({ name = "gopls" }, function(_, client)
                    if not client.server_capabilities.semanticTokensProvider then
                        local semantic = vim.tbl_get(
                            client.config,
                            "capabilities",
                            "textDocument",
                            "semanticTokens"
                        ) or vim.lsp.protocol.make_client_capabilities().textDocument.semanticTokens
                        if semantic then
                            client.server_capabilities.semanticTokensProvider = {
                                full = true,
                                legend = {
                                    tokenTypes = semantic.tokenTypes,
                                    tokenModifiers = semantic.tokenModifiers,
                                },
                                range = true,
                            }
                        end
                    end
                end)
            end

            return opts
        end,
    },
}
