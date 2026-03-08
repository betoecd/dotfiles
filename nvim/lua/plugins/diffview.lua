return {
	"sindrets/diffview.nvim",
	config = function()
		require("diffview").setup()

		vim.keymap.set("n", "<leader>gd", ":DiffviewOpen<CR>", { desc = "Open Diffview" })
		vim.keymap.set("n", "<leader>gc", ":DiffviewClose<CR>", { desc = "Close Diffview" })
		vim.keymap.set("n", "<leader>gh", ":DiffviewFileHistory %<CR>", { desc = "File history (current file)" })
		vim.keymap.set("n", "<leader>gH", ":DiffviewFileHistory<CR>", { desc = "File history (all)" })
	end,
}
