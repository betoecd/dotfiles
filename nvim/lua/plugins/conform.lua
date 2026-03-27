local function has_biome_config(ctx)
    return vim.fs.find({ "biome.json", "biome.jsonc" }, { path = ctx.dirname, upward = true })[1] ~= nil
end

return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            typescript = { "biome", "prettier", "eslint_d" },
            typescriptreact = { "biome", "prettier", "eslint_d" },
            javascript = { "biome", "prettier", "eslint_d" },
            javascriptreact = { "biome", "prettier", "eslint_d" },
        },
        formatters = {
            biome = {
                condition = function(self, ctx)
                    return has_biome_config(ctx)
                end,
            },
            prettier = {
                condition = function(self, ctx)
                    return not has_biome_config(ctx)
                end,
                prepend_args = function(_, ctx)
                    -- Only use config file if it exists in the project
                    local config_files = {
                        ".prettierrc",
                        ".prettierrc.json",
                        ".prettierrc.yml",
                        ".prettierrc.yaml",
                        ".prettierrc.json5",
                        ".prettierrc.js",
                        ".prettierrc.cjs",
                        "prettier.config.js",
                        "prettier.config.cjs",
                    }

                    -- Check if any prettier config exists
                    local has_config = false
                    for _, config_file in ipairs(config_files) do
                        if vim.fn.filereadable(vim.fn.getcwd() .. "/" .. config_file) == 1 then
                            has_config = true
                            break
                        end
                    end

                    -- Return empty args to let prettier auto-detect config
                    return {}
                end,
            },
            eslint_d = {
                condition = function(self, ctx)
                    return not has_biome_config(ctx)
                end,
            },
        },
        -- Format on save
        format_on_save = function(bufnr)
            -- Disable autoformat for certain filetypes
            local ignore_filetypes = { "sql", "java" }
            if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
                return
            end

            return {
                timeout_ms = 500,
                lsp_fallback = true,
            }
        end,
    },
}
