local vgit = require("vgit")
local Remap = require("keymap")
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
			format = function(blame, git_config)
				local config_author = git_config["user.name"]
				local author = blame.author
				if config_author == author then
					author = "You"
				end
				local time = os.difftime(os.time(), blame.author_time) / (60 * 60 * 24 * 30 * 12)
				local time_divisions = {
					{ 1, "years" },
					{ 12, "months" },
					{ 30, "days" },
					{ 24, "hours" },
					{ 60, "minutes" },
					{ 60, "seconds" },
				}
				local counter = 1
				local time_division = time_divisions[counter]
				local time_boundary = time_division[1]
				local time_postfix = time_division[2]
				while time < 1 and counter ~= #time_divisions do
					time_division = time_divisions[counter]
					time_boundary = time_division[1]
					time_postfix = time_division[2]
					time = time * time_boundary
					counter = counter + 1
				end
				local commit_message = blame.commit_message
				if not blame.committed then
					author = "You"
					commit_message = "Uncommitted changes"
					return string.format(" %s • %s", author, commit_message)
				end
				local max_commit_message_length = 255
				if #commit_message > max_commit_message_length then
					commit_message = commit_message:sub(1, max_commit_message_length) .. "..."
				end
				return string.format(
					" %s, %s • %s",
					author,
					string.format(
						"%s %s ago",
						time >= 0 and math.floor(time + 0.5) or math.ceil(time - 0.5),
						time_postfix
					),
					commit_message
				)
			end,
		},
		live_gutter = {
			enabled = true,
			edge_navigation = true, -- This allows users to navigate within a hunk
		},
		authorship_code_lens = {
			enabled = true,
		},
		scene = {
			diff_preference = "unified", -- unified or split
			keymaps = {
				quit = "q",
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
		project_diff_preview = {
			keymaps = {
				buffer_stage = "s",
				buffer_unstage = "u",
				buffer_hunk_stage = "gs",
				buffer_hunk_unstage = "gu",
				buffer_reset = "r",
				stage_all = "S",
				unstage_all = "U",
				reset_all = "R",
			},
		},
		signs = {
			priority = 10,
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
			usage = {
				screen = {
					add = "GitSignsAddLn",
					remove = "GitSignsDeleteLn",
				},
				main = {
					add = "GitSignsAdd",
					remove = "GitSignsDelete",
					change = "GitSignsChange",
				},
			},
		},
		symbols = {
			void = "⣿",
		},
	},
})

nnoremap('<leader>gd', function ()
    vgit.buffer_diff_preview()
end)

nnoremap("<leader>gD", function ()
    vgit.project_diff_preview()
end)

nnoremap("<leader>gh", function ()
    vgit.buffer_history_preview()
end)

nnoremap('<leader>ga', function ()
    vgit.buffer_stage()
end)

nnoremap('<leader>gu', function ()
    vgit.buffer_unstage()
end)

nnoremap('<leader>gA', function ()
    vgit.project_stage_all()
end)

nnoremap('<leader>gU', function ()
    vgit.project_unstage_all()
end)

-- tpope vim-fugutive
nnoremap('<leader>gs', function ()
    vim.cmd('Git status')
end)

nnoremap('<leader>gc', function ()
    vim.cmd('Git commit')
end)
