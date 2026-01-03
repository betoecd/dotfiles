-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- stylua: ignore
---@diagnostic disable: undefined-global

--------------
-- obsidian --
--------------
--
-- >>> oo # from shell, navigate to vault (optional)
--
-- # NEW NOTE
-- >>> on "Note Name" # call my "obsidian new note" shell script (~/bin/on)
-- >>>
-- >>> ))) <leader>on # inside vim now, format note as template
-- >>> ))) # add tag, e.g. fact / blog / video / etc..
-- >>> ))) # add hubs, e.g. [[python]], [[machine-learning]], etc...
-- >>> ))) <leader>of # format title
--
-- # END OF DAY/WEEK REVIEW
-- >>> or # review notes in inbox
-- >>>
-- >>> ))) <leader>ok # inside vim now, move to zettelkasten
-- >>> ))) <leader>odd # or delete
-- >>>
-- >>> og # organize saved notes from zettelkasten into notes/[tag] folders
-- >>> ou # sync local with Notion
--
-- navigate to vault
vim.keymap.set(
	"n",
	"<leader>zo",
	":cd /Users/ebertondias/library/Mobile\\ Documents/iCloud~md~obsidian/Documents/bits<cr>"
)
--
-- convert note to template and remove leading white space
vim.keymap.set("n", "<leader>zn", ":ObsidianTemplate note<cr> :lua vim.cmd([[1,/^\\S/s/^\\n\\{1,}//]])<cr>")
-- strip date from note title and replace dashes with spaces
-- must have cursor on title
vim.keymap.set("n", "<leader>zf", ":s/\\(# \\)[^_]*_/\\1/ | s/-/ /g<cr>")
--
-- search for files in full vault
vim.keymap.set(
    "n",
    "<leader>zs",
    ':Telescope find_files search_dirs={"/Users/ebertondias/library/Mobile\\ Documents/iCloud~md~obsidian/Documents/bits/notes"}<cr>'
)
vim.keymap.set(
    "n",
    "<leader>zz",
    ':Telescope live_grep search_dirs={"/Users/ebertondias/library/Mobile\\ Documents/iCloud~md~obsidian/Documents/bits/notes"}<cr>'
)
--
-- search for files in notes (ignore beto)
-- vim.keymap.set("n", "<leader>ois", ":Telescope find_files search_dirs={\"/Users/ebertondias/library/Mobile\\ Documents/iCloud~md~obsidian/Documents/bits/notes\"}<cr>")
-- vim.keymap.set("n", "<leader>oiz", ":Telescope live_grep search_dirs={\"/Users/ebertondias/library/Mobile\\ Documents/iCloud~md~obsidian/Documents/bits/notes\"}<cr>")
--
-- for review workflow
-- move file in current buffer to zettelkasten folder
vim.keymap.set(
    "n",
    "<leader>zk",
    ":!mv '%:p' /Users/ebertondias/library/Mobile\\ Documents/iCloud~md~obsidian/Documents/bits/beto<cr>:bd<cr>"
)
-- delete file in current buffer
vim.keymap.set("n", "<leader>zdd", ":!rm '%:p'<cr>:bd<cr>")
