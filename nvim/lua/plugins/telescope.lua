return {
  {
    "prochri/telescope-all-recent.nvim",
    opts = {
      default = {
        disable = true,
        sorting = "frequency",
      },
    },
    dependencies = {
      "kkharji/sqlite.lua",
      {
        "nvim-telescope/telescope.nvim",
        dependencies = {
          { "nvim-lua/plenary.nvim", cmd = { "PlenaryBustedDirectory", "PlenaryBustedFile" } },
        },
        opts = function()
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

          return {
            defaults = {
              buffer_previewer_maker = new_maker,
            },
          }
        end,
        keys = {
          {
            "gff",
            function()
              require("telescope.builtin").find_files()
            end,
            desc = "Find Plugin File",
          },
          {
            "gfo",
            function()
              require("telescope.builtin").oldfiles()
            end,
            desc = "Find history",
          },
          {
            "gfo",
            function()
              require("telescope.builtin").buffers()
            end,
            desc = "Find buffers",
          },
          {
            "gfg",
            function()
              require("telescope.builtin").live_grep()
            end,
            desc = "Live grep",
          },
          {
            "gfh",
            function()
              require("telescope.builtin").help_tags()
            end,
            desc = "Help tags",
          },
          {
            "gft",
            function()
              require("telescope.builtin").treesitter()
            end,
            desc = "Telescope treesitter",
          },
          {
            "gfk",
            function()
              require("telescope.builtin").keymaps()
            end,
            desc = "Telescope keymaps",
          },
          {
            "<leader>qf",
            function()
              require("telescope.builtin").quickfix()
            end,
            desc = "Telescope quickfix",
          },
          {
            "<leader>gb",
            function()
              require("telescope.builtin").git_branches()
            end,
            desc = "Git branches",
          },
          {
            "<leader>gc",
            function()
              require("telescope.builtin").git_commits()
            end,
            desc = "Git commits",
          },
          {
            "gfp",
            function()
              require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
            end,
            desc = "Find Plugin File",
          },
        },
      },
    },
  },
}
