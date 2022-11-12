local vgit = require("vgit")
local Remap = require("logan.keymap")
local nnoremap = Remap.nnoremap

vgit.setup({
	settings = {
		hls = {
			GitBackground = "Normal",
			GitHeader = "NormalFloat",
			GitFooter = "NormalFloat",
			GitBorder = "LineNr",
			jkkkkGitLineNr = "LineNr",
			GitComment = "Comment",
			GitSignsAdd = {
				gui = nil,
				fg = "#5d7a22",
				bg = nil,
				sp = nil,
				override = false,
			},
			GitSignsChange = {
				gui = nil,
				fg = "#7AA6DA",
				bg = nil,
				sp = nil,
				override = false,
			},
			GitSignsDelete = {
				gui = nil,
				fg = "#e95678",
				bg = nil,
				sp = nil,
				override = false,
			},
			GitSignsAddLn = "DiffAdd",
			GitSignsDeleteLn = "DiffDelete",
			GitWordAdd = {
				gui = nil,
				fg = nil,
				bg = "#5d7a22",
				sp = nil,
				override = false,
			},
			GitWordDelete = {
				gui = nil,
				fg = nil,
				bg = "#960f3d",
				sp = nil,
				override = false,
			},
		},
		live_blame = {
			enabled = false,
		},
		live_gutter = {
			enabled = true,
			edge_navigation = true, -- This allows users to navigate within a hunk
		},
		scene = {
			diff_preference = "unified", -- unified or split
			keymaps = {
				quit = "<esc>",
			},
		},
		diff_preview = {
			keymaps = {
				buffer_stage = "S",
				buffer_unstage = "U",
				buffer_hunk_stage = "s",
				buffer_hunk_unstage = "u",
				toggle_view = "t",
			},
		},
		signs = {
			priority = 1,
			definitions = {
				GitSignsAddLn = {
					linehl = "GitSignsAddLn",
					texthl = nil,
					numhl = nil,
					icon = nil,
					text = "",
				},
				GitSignsDeleteLn = {
					linehl = "GitSignsDeleteLn",
					texthl = nil,
					numhl = nil,
					icon = nil,
					text = "",
				},
				GitSignsAdd = {
					texthl = "GitSignsAdd",
					numhl = nil,
					icon = nil,
					linehl = nil,
					text = "┃",
				},
				GitSignsDelete = {
					texthl = "GitSignsDelete",
					numhl = nil,
					icon = nil,
					linehl = nil,
					text = "┃",
				},
				GitSignsChange = {
					texthl = "GitSignsChange",
					numhl = nil,
					icon = nil,
					linehl = nil,
					text = "┃",
				},
			},
		},
	},
})

nnoremap("<leader>gg", function ()
    vim.cmd("Git")
end)
