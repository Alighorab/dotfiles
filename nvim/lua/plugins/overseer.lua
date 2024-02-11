return {
  {
    {
      "stevearc/overseer.nvim",
      opts = function()
        vim.api.nvim_create_user_command("OverseerRestartLast", function()
          local overseer = require("overseer")
          local tasks = overseer.list_tasks({ recent_first = true })
          if vim.tbl_isempty(tasks) then
            vim.notify("No tasks found", vim.log.levels.WARN)
          else
            overseer.run_action(tasks[1], "restart")
          end
        end, {})
        vim.keymap.set("n", "<F5>", vim.cmd.OverseerRestartLast, {
          silent = true,
          buffer = true,
          desc = "Restart Last Task",
        })
        return {
          dap = false,
          templates = { "cargo", "npm", "vscode" },
          task_list = {
            direction = "bottom",
            min_height = 10,
            max_height = 25,
            default_detail = 1,
            bindings = {
              ["q"] = function()
                vim.cmd("OverseerClose")
              end,
            },
          },
        }
      end,
      keys = {
        {
          "<F6>",
          function()
            require("overseer").run_template(nil, require("overseer").open)
          end,
          { noremap = true, silent = true, desc = "Overseer Open" },
        },
        {
          "<F18>",
          function()
            require("overseer").toggle()
          end,
          { noremap = true, silent = true, desc = "Overseer Toggle Results" },
        },
      },
      dependencies = {
        "mfussenegger/nvim-dap",
      },
    },
    { "stevearc/dressing.nvim" },
  },
}
