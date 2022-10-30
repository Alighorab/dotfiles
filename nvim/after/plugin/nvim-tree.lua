local Remap = require("logan.keymap")
local nnoremap = Remap.nnoremap
local silent = { silent = true }
local api = require("nvim-tree.api")

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
	sort_by = "case_sensitive",
	auto_reload_on_write = true,
	open_on_setup = false,
	view = {
		adaptive_size = true,
		relativenumber = true,
		number = true,
		float = {
			enable = false,
			open_win_config = {
				relative = "editor",
				border = "rounded",
				width = 60,
				height = 24,
				row = 8,
				col = 60,
			},
		},
	},
	renderer = {
		group_empty = true,
		highlight_opened_files = "all",
		indent_markers = {
			enable = true,
			inline_arrows = true,
			icons = {
				corner = "└",
				edge = "│",
				item = "│",
				bottom = "─",
				none = " ",
			},
		},
		icons = {
			webdev_colors = true,
			git_placement = "after",
			padding = " ",
			symlink_arrow = " ➛ ",
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
			},
			glyphs = {
				default = "",
				symlink = "",
				bookmark = "",
				folder = {
					arrow_closed = "",
					arrow_open = "",
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
					symlink_open = "",
				},
				git = {
					unstaged = "M",
					staged = "S",
					unmerged = "",
					renamed = "➜",
					untracked = "A",
					deleted = "D",
					ignored = "I",
				},
			},
		},
	},
	filters = {
		dotfiles = true,
		custom = { "^.git$" },
	},
	diagnostics = {
		enable = true,
		icons = { hint = "", info = "", warning = "", error = "" },
		show_on_dirs = true,
	},
	actions = {
		open_file = {
			quit_on_open = true,
		},
	},
	git = {
		enable = true,
		ignore = true,
		show_on_dirs = true,
		timeout = 400,
	},
})

nnoremap("<leader><leader>", function ()
    api.tree.toggle()
    api.tree.reload()
end, silent)
