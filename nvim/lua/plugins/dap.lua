return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        opts = {
          layouts = {
            {
              elements = {
                { id = "watches", size = 0.25 },
                { id = "scopes",  size = 0.5 },
                { id = "repl",    size = 0.25 },
              },
              size = 79,
              position = "left",
            },
            {
              elements = {
                "console",
              },
              size = 0.25,
              position = "bottom",
            },
          },
          controls = {
            -- Requires Neovim nightly (or 0.8 when released)
            enabled = true,
            -- Display controls in this element
            element = "repl",
          },
        },
        config = function(_, opts)
          local dapui = require("dapui")
          dapui.setup(opts)
          vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "", linehl = "", numhl = "" })
          vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "", linehl = "", numhl = "" })
          vim.fn.sign_define("DapStopped", { text = "▶", texthl = "", linehl = "", numhl = "" })
        end,
      },
      "mfussenegger/nvim-dap-python",
      {
        "Joakker/lua-json5",
        build = "./install.sh",
      },
    },
    config = function()
      local dap = require("dap")
      local dap_vscode = require("dap.ext.vscode")
      local dapui = require("dapui")
      local push = require("stackmap").push
      local pop = require("stackmap").pop
      local function after_session()
        dapui.close()
        dap.repl.close()
      end

      dap.defaults.fallback.force_external_terminal = true
      dap.listeners.after.event_initialized["dapui_config"] = dapui.open
      dap.listeners.after.event_terminated["dapui_config"] = after_session
      dap.listeners.after.event_exited["dapui_config"] = after_session
      dap.listeners.after.disconnect["dapui_config"] = after_session

      dap.listeners.after["event_initialized"]["me"] = function()
        push("debug_mode", "n", {
          {
            "<F7>",
            function(_)
              dap.terminate(_, _, function()
                dap.repl.close()
                dapui.close()
              end)
            end,
            { desc = "Dap terminate" },
          },
          { "<F10>",      dap.step_over,                   { desc = "Dap step over" } },
          { "<F11>",      dap.step_into,                   { desc = "Dap step into" } },
          { "<F12>",      dap.step_out,                    { desc = "Dap step out" } },
          { "<leader>rc", dap.run_to_cursor,               { desc = "Dap run to cursor" } },
          { "<leader>dp", dap.pause,                       { desc = "Dap pause" } },
          { "K",          require("dap.ui.widgets").hover, { desc = "Dap hover" } },
        })
        push("debug_mode", "i", {
          {
            "<F7>",
            function(_)
              dap.terminate(_, _, function()
                dap.repl.close()
                dapui.close()
              end)
            end,
            { desc = "Dap terminate" },
          },
          { "<F10>", dap.step_over, { desc = "Dap step over" } },
          { "<F11>", dap.step_into, { desc = "Dap step into" } },
          { "<F12>", dap.step_out,  { desc = "Dap step out" } },
        })
      end

      dap.listeners.after["event_terminated"]["me"] = function()
        pop("debug_mode", "n")
        pop("debug_mode", "i")
      end

      -- add support to vscode launch.json
      dap_vscode.json_decode = require("json5").parse

      -- add support to preLaunchTask and postDebugTask
      require("overseer").patch_dap(true)

      -- Adapters
      require("plugins.debug-adapters.codelldb").setup()
      require("plugins.debug-adapters.debugpy").setup()
    end,
    keys = {
      {
        "<F9>",
        function()
          require("dap").continue()
        end,
        desc = "Dap continue",
      },
      {
        "<F21>",
        function()
          require("dap").run_last()
        end,
        desc = "Dap run last",
      },
      {
        "<F8>",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Dap toggle breakpoint",
      },
      {
        "<F20>",
        function()
          require("dap").clear_breakpoints()
        end,
        desc = "Dap clear breakpoints",
      },
      {
        "<leader>B",
        function()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        desc = "Dap conditional breakpoint",
      },
    },
  },
}
