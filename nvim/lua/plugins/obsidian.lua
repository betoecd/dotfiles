return {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
    },
    opts = {
        workspaces = {
            {
                name = "bits",
                path = "/Users/ebertondias/library/Mobile Documents/iCloud~md~obsidian/Documents/bits",
            },
        },
        notes_subdir = "inbox",
        new_notes_location = "notes_subdir",

        disable_frontmatter = true,
        templates = {
            subdir = "templates",
            date_format = "%Y-%m-%d",
            time_format = "%H:%M:%S",
        },
        mappings = {
            -- overrides the 'gf' mapping to work on markdown/wiki links within your vault
            ["gf"] = {
                action = function()
                    return require("obsidian").util.gf_passthrough()
                end,
                opts = { noremap = false, expr = true, buffer = true },
            },
            -- toggle check-boxes
            ["<leader>ti"] = {
                action = function()
                    return require("obsidian").util.toggle_checkbox()
                end,
                opts = { buffer = true },
            },
        },
        ui = {
            -- Disable some things below here because I set these manually for all Markdown files using treesitter
            checkboxes = {},
            bullets = {},
        },
    },
}
