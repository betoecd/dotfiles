return {
    "neovim/nvim-lspconfig",
    opts = {
        servers = {
            ruff = {
                cmd = { "ruff", "server", "--preview" },
                cmd_env = { RUFF_TRACE = "messages" },
                init_options = {
                    settings = {
                        logLevel = "error",
                        lineLength = 120,
                        format = {
                            preview = true,
                        },
                    },
                },
                keys = {
                    {
                        "<leader>co",
                        LazyVim.lsp.action["source.organizeImports"],
                        desc = "Organize Imports",
                    },
                },
                on_attach = function(client, bufnr)
                    -- Organize imports on save
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        callback = function()
                            LazyVim.lsp.action["source.organizeImports"]()
                        end,
                    })
                end,
            },
            ruff_lsp = {
                keys = {
                    {
                        "<leader>co",
                        LazyVim.lsp.action["source.organizeImports"],
                        desc = "Organize Imports",
                    },
                },
            },
        },
        setup = {
            ["ruff"] = function()
                Snacks.util.lsp.on({ name = "ruff" }, function(buf, client)
                    -- Disable hover in favor of Pyright
                    client.server_capabilities.hoverProvider = false
                end)
            end,
        },
    },
}
