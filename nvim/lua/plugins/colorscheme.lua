return {
    {
        "catppuccin/nvim",
        lazy = false,
        name = "catppuccin",
        priority = 1000,

        config = function()
            require("catppuccin").setup({
                transparent_background = true,
            })
            vim.cmd.colorscheme("catppuccin-mocha")
        end,
    },
}

-- return {
--     "rose-pine/neovim",
--     name = "rose-pine-moon",
--     config = function()
--         require("rose-pine").setup({
--             variant = "moon",
--             disable_background = true,
--             disable_float_background = true,
--             disable_italics = true,
--             dim_inactive = {
--                 enabled = true,
--                 shade = "dark",
--                 percentage = 0.15,
--             },
--         })
--         vim.cmd.colorscheme("rose-pine-moon")
--     end,
-- }
