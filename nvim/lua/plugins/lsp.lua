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
                LazyVim.lsp.on_attach(function(client, _)
                    -- Disable hover in favor of Pyright
                    client.server_capabilities.hoverProvider = false
                end, "ruff")
            end,
        },
    },
}
