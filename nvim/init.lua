-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.opt.autoread = true

vim.api.nvim_create_augroup("AutoReload", { clear = true })
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
    command = "checktime",
    group = "AutoReload",
})
