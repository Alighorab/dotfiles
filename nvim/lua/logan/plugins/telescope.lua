local previewers = require("telescope.previewers")
local Job = require("plenary.job")

local new_maker = function(filepath, bufnr, opts)
  filepath = vim.fn.expand(filepath)
  Job:new({
    command = "file",
    args = { "--mime-type", "-b", filepath },
    on_exit = function(j)
      local mime_type = vim.split(j:result()[1], "/")[1]
      if mime_type == "text" then
        previewers.buffer_previewer_maker(filepath, bufnr, opts)
      else
        -- maybe we want to write something to the buffer here
        vim.schedule(function()
          vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
        end)
      end
    end,
  }):sync()
end

require("telescope").setup({
  defaults = {
    buffer_previewer_maker = new_maker,
  },
})

local builtin = require("telescope.builtin")

vim.keymap.set("n", "gff", builtin.find_files, { desc = "Telescope find_files" })
vim.keymap.set("n", "gfg", builtin.live_grep, { desc = "Telescope live_grep" })
vim.keymap.set("n", "gfh", builtin.help_tags, { desc = "Telescope help_tags" })
vim.keymap.set("n", "gft", builtin.treesitter, { desc = "Telescope treesitter" })
vim.keymap.set("n", "gfk", builtin.keymaps, { desc = "Telescope keymaps" })
vim.keymap.set("n", "<leader>qf", builtin.quickfix, { desc = "Telescope quickfix" })

vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Git branches" })
vim.keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "Git commits" })
