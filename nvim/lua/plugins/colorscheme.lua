return {
    {
        "adibhanna/yukinord.nvim",
        priority = 1000,
        config = function()
            -- vim.cmd.colorscheme("yukinord")
        end,
    },
    {
        "rose-pine/neovim",
        name = "rose-pine-moon",
        config = function()
            require("rose-pine").setup({
                variant = "moon",
                disable_background = true,
                disable_float_background = true,
                disable_italics = true,
                dim_inactive = {
                    enabled = true,
                    shade = "dark",
                    percentage = 0.15,
                },
            })
            vim.cmd.colorscheme("rose-pine-moon")
        end,
    },
    {
        "nyoom-engineering/oxocarbon.nvim",
        -- Add in any other configuration;
        --   event = foo,
        --   config = bar
        --   end,
    },
    {
        "sainnhe/everforest",
        lazy = false,
        priority = 1000,
        config = function()
            -- Optionally configure and load the colorscheme
            -- directly inside the plugin declaration.
            vim.g.everforest_enable_italic = true
            -- vim.cmd.colorscheme('everforest')
        end,
    },
    {
        "craftzdog/solarized-osaka.nvim",
        lazy = false,
        priority = 1000,
        opts = function()
            return {
                transparent = true,
            }
        end,
    },
    {
        "datsfilipe/vesper.nvim",
        lazy = false,
        priority = 1000,

        opts = function()
            return {
                transparent = true,
            }
        end,
    },
    {
        "catppuccin/nvim",
        lazy = false,
        name = "catppuccin",
        priority = 1000,

        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                transparent_background = true,
                no_italic = true,
                dim_inactive = {
                    enabled = true,
                    shade = "dark",
                    percentage = 0.15,
                },
            })
            -- vim.cmd.colorscheme("catppuccin")
        end,
    },
}
