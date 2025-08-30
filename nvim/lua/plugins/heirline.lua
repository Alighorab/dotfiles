return {
  "rebelot/heirline.nvim",
  event = "BufEnter",
  opts = function()
    local conditions = require("heirline.conditions")
    local utils = require("heirline.utils")

    local Separator = {
      provider = " ",
      hl = {
        fg = "None",
        bg = "None",
      },
    }

    local ViMode = {
      -- get vim current mode, this information will be required by the provider
      -- and the highlight functions, so we compute it only once per component
      -- evaluation and store it as a component attribute
      init = function(self)
        self.mode = vim.fn.mode(1) -- :h mode()
      end,
      -- Now we define some dictionaries to map the output of mode() to the
      -- corresponding string and color. We can put these into `static` to compute
      -- them at initialisation time.
      static = {
        mode_names = {
          -- change the strings if you like it vvvvverbose!
          n = "NORMAL",
          no = "NORMAL?",
          nov = "NORMAL?",
          noV = "NORMAL?",
          ["no\22"] = "NORMAL?",
          niI = "NORMALi",
          niR = "NORMALr",
          niV = "NORMALv",
          nt = "NORMALt",
          v = "VISUAL",
          vs = "VISUALs",
          V = "VISUAL-LINE",
          Vs = "VISUALs",
          ["\22"] = "VISUAL-BLOCK",
          ["\22s"] = "VISUAL-BLOCK",
          s = "SELECT",
          S = "SELECT_",
          ["\19"] = "^SELECT",
          i = "INSERT",
          ic = "INSERTc",
          ix = "INSERTx",
          R = "REPLACE",
          Rc = "REPLACEc",
          Rx = "REPLACEx",
          Rv = "REPLACEv",
          Rvc = "REPLACEv",
          Rvx = "REPLACEv",
          c = "CMDLINE",
          cv = "EX",
          r = "...",
          rm = "M",
          ["r?"] = "?",
          ["!"] = "!",
          t = "TERMINAL",
        },
        mode_colors = {
          n = "red",
          i = "green",
          v = "cyan",
          V = "cyan",
          ["\22"] = "cyan",
          c = "orange",
          s = "purple",
          S = "purple",
          ["\19"] = "purple",
          R = "orange",
          r = "orange",
          ["!"] = "red",
          t = "red",
        },
      },
      -- We can now access the value of mode() that, by now, would have been
      -- computed by `init()` and use it to index our strings dictionary.
      -- note how `static` fields become just regular attributes once the
      -- component is instantiated.
      -- To be extra meticulous, we can also add some vim statusline syntax to
      -- control the padding and make sure our string is always at least 2
      -- characters long. Plus a nice Icon.

      utils.surround({ "", "" }, "bright_bg", {
        {
          provider = function(self)
            return "%2(" .. self.mode_names[self.mode] .. "%)"
          end,
          -- Same goes for the highlight. Now the foreground will change according to the current mode.
          hl = function(self)
            local mode = self.mode:sub(1, 1) -- get only the first mode character
            return { fg = self.mode_colors[mode], bold = true, bg = "bright_bg" }
          end,
        },
      }),
      Separator,
      -- Re-evaluate the component only on ModeChanged event!
      -- Also allows the statusline to be re-evaluated when entering operator-pending mode
      update = {
        "ModeChanged",
        pattern = "*:*",
        callback = vim.schedule_wrap(function()
          vim.cmd("redrawstatus")
        end),
      },
    }

    local FileNameBlock = {
      -- let's first set up some attributes needed by this component and it's children
      init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
      end,
    }

    local FileIcon = {
      init = function(self)
        local filename = self.filename
        local extension = vim.fn.fnamemodify(filename, ":e")
        self.icon, self.icon_color =
            require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
      end,
      provider = function(self)
        return self.icon and (self.icon .. " ")
      end,
      hl = function(self)
        return { fg = self.icon_color }
      end,
    }

    local FileName = {
      provider = function(self)
        -- first, trim the pattern relative to the current directory. For other
        -- options, see :h filename-modifers
        local filename = vim.fn.fnamemodify(self.filename, ":.")
        if filename == "" then
          return "[No Name]"
        end
        -- now, if the filename would occupy more than 1/4th of the available
        -- space, we trim the file path to its initials
        -- See Flexible Components section below for dynamic truncation
        if not conditions.width_percent_below(#filename, 0.25) then
          filename = vim.fn.pathshorten(filename)
        end
        return filename
      end,
      hl = { fg = utils.get_highlight("Directory").fg },
    }

    local FileFlags = {
      {
        condition = function()
          return vim.bo.modified
        end,
        provider = "[+]",
        hl = { fg = "green" },
      },
      {
        condition = function()
          return not vim.bo.modifiable or vim.bo.readonly
        end,
        provider = " ",
        hl = { fg = "orange" },
      },
    }

    -- Now, let's say that we want the filename color to change if the buffer is
    -- modified. Of course, we could do that directly using the FileName.hl field,
    -- but we'll see how easy it is to alter existing components using a "modifier"
    -- component

    local FileNameModifer = {
      hl = function()
        if vim.bo.modified then
          -- use `force` because we need to override the child's hl foreground
          return { fg = "cyan", bold = true, force = true }
        end
      end,
    }

    -- let's add the children to our FileNameBlock component
    FileNameBlock = utils.insert(
      FileNameBlock,
      FileIcon,
      utils.insert(FileNameModifer, FileName), -- a new table where FileName is a child of FileNameModifier
      FileFlags,
      { provider = "%<" }                      -- this means that the statusline is cut here when there's not enough space
    )

    local FileType = {
      condition = function()
        return vim.bo.filetype ~= ""
      end,
      utils.surround({ "", "" }, "bright_bg", {
        provider = function()
          return vim.bo.filetype
        end,
        hl = { fg = utils.get_highlight("Type").fg, bold = false },
      }),
      Separator,
    }

    local LSPActive = {
      condition = conditions.lsp_attached,
      update = { "LspAttach", "LspDetach" },
      -- You can keep it simple,
      -- provider = " [LSP]",

      -- Or complicate things a bit and get the servers names
      utils.surround({ "", "" }, "bright_bg", {
        provider = function()
          local names = {}
          for _, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
            table.insert(names, server.name)
          end
          return " " .. table.concat(names, " ")
        end,
        hl = { fg = "green", bold = true },
      }),
      Separator,
    }

    local Diagnostics = {
      condition = conditions.has_diagnostics,
      static = {
        error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
        warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
        info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
        hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
      },
      init = function(self)
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
      end,
      update = { "DiagnosticChanged", "BufEnter" },
      utils.surround({ "", "" }, "bright_bg", {
        {
          provider = function(self)
            -- 0 is just another output, we can decide to print it or not!
            return self.errors > 0 and (self.error_icon .. self.errors .. " ")
          end,
          hl = { fg = "diag_error" },
        },
        {
          provider = function(self)
            return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
          end,
          hl = { fg = "diag_warn" },
        },
        {
          provider = function(self)
            return self.info > 0 and (self.info_icon .. self.info .. " ")
          end,
          hl = { fg = "diag_info" },
        },
        {
          provider = function(self)
            return self.hints > 0 and (self.hint_icon .. self.hints)
          end,
          hl = { fg = "diag_hint" },
        },
      }),
      Separator,
    }

    local Git = {
      condition = conditions.is_git_repo,
      init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
        self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
      end,
      utils.surround({ "", "" }, "bright_bg", {
        hl = { fg = "orange" },
        {
          -- git branch name
          provider = function(self)
            return " " .. self.status_dict.head
          end,
          hl = { bold = true },
        },
        -- You could handle delimiters, icons and counts similar to Diagnostics
        {
          condition = function(self)
            return self.has_changes
          end,
          provider = "(",
        },
        {
          provider = function(self)
            local count = self.status_dict.added or 0
            return count > 0 and ("+" .. count)
          end,
          hl = { fg = "git_add" },
        },
        {
          provider = function(self)
            local count = self.status_dict.removed or 0
            return count > 0 and ("-" .. count)
          end,
          hl = { fg = "red" },
        },
        {
          provider = function(self)
            local count = self.status_dict.changed or 0
            return count > 0 and ("~" .. count)
          end,
          hl = { fg = "git_change" },
        },
        {
          condition = function(self)
            return self.has_changes
          end,
          provider = ")",
        },
      }),
      Separator,
    }

    -- Full nerd (with icon colors and clickable elements)!
    -- works in multi window, but does not support flexible components (yet ...)
    local Navic = {
      condition = function()
        return require("nvim-navic").is_available()
      end,
      static = {
        -- create a type highlight map
        type_hl = {
          File = "Directory",
          Module = "@include",
          Namespace = "@namespace",
          Package = "@include",
          Class = "@structure",
          Method = "@method",
          Property = "@property",
          Field = "@field",
          Constructor = "@constructor",
          Enum = "@field",
          Interface = "@type",
          Function = "@function",
          Variable = "@variable",
          Constant = "@constant",
          String = "@string",
          Number = "@number",
          Boolean = "@boolean",
          Array = "@field",
          Object = "@type",
          Key = "@keyword",
          Null = "@comment",
          EnumMember = "@field",
          Struct = "@structure",
          Event = "@keyword",
          Operator = "@operator",
          TypeParameter = "@type",
        },
        -- bit operation dark magic, see below...
        enc = function(line, col, winnr)
          return bit.bor(bit.lshift(line, 16), bit.lshift(col, 6), winnr)
        end,
        -- line: 16 bit (65535); col: 10 bit (1023); winnr: 6 bit (63)
        dec = function(c)
          local line = bit.rshift(c, 16)
          local col = bit.band(bit.rshift(c, 6), 1023)
          local winnr = bit.band(c, 63)
          return line, col, winnr
        end,
      },
      init = function(self)
        local data = require("nvim-navic").get_data() or {}
        local children = {}
        -- create a child for each level
        for i, d in ipairs(data) do
          -- encode line and column numbers into a single integer
          local pos = self.enc(d.scope.start.line, d.scope.start.character, self.winnr)
          local child = {
            {
              provider = d.icon,
              hl = self.type_hl[d.type],
            },
            {
              -- escape `%`s (elixir) and buggy default separators
              provider = d.name:gsub("%%", "%%%%"):gsub("%s*->%s*", ""),
              -- highlight icon only or location name as well
              -- hl = self.type_hl[d.type],

              on_click = {
                -- pass the encoded position through minwid
                minwid = pos,
                callback = function(_, minwid)
                  -- decode
                  local line, col, winnr = self.dec(minwid)
                  vim.api.nvim_win_set_cursor(vim.fn.win_getid(winnr), { line, col })
                end,
                name = "heirline_navic",
              },
            },
          }
          -- add a separator only if needed
          if #data > 1 and i < #data then
            table.insert(child, {
              provider = " > ",
              hl = { fg = "bright_fg" },
            })
          end
          table.insert(children, child)
        end
        -- instantiate the new child, overwriting the previous one
        self.child = self:new(children, 1)
      end,
      -- evaluate the children containing navic components
      provider = function(self)
        return self.child:eval()
      end,
      hl = { fg = "gray" },
      update = "CursorMoved",
      Separator,
    }

    local WorkDir = {
      utils.surround({ "", "" }, "bright_bg", {
        provider = function()
          local icon = " "
          local cwd = vim.fn.getcwd(0)
          cwd = vim.fn.fnamemodify(cwd, ":t")
          if not conditions.width_percent_below(#cwd, 0.25) then
            cwd = vim.fn.pathshorten(cwd)
          end
          return icon .. cwd
        end,
        hl = { fg = "blue", bold = true },
      }),
      Separator,
    }

    local Ruler = {
      -- %l = current line number
      -- %L = number of lines in the buffer
      -- %c = column number
      -- %P = percentage through file of displayed window
      utils.surround({ "", "" }, "bright_bg", {
        provider = "%7(%l/%3L%):%2c %P",
      }),
    }

    local HelpFileName = {
      condition = function()
        return vim.bo.filetype == "help"
      end,
      utils.surround({ "", "" }, "bright_bg", {
        provider = function()
          local filename = vim.api.nvim_buf_get_name(0)
          return vim.fn.fnamemodify(filename, ":t")
        end,
      }),
      hl = { fg = "blue", bold = true },
    }

    local Align = {
      provider = "%=",
    }

    local Reset = {
      provider = "%#None#",
    }

    local function rpad(child)
      return {
        condition = child.condition,
        child,
      }
    end
    local function OverseerTasksForStatus(status)
      return {
        condition = function(self)
          return self.tasks[status]
        end,
        provider = function(self)
          return string.format("%s%d ", self.symbols[status], #self.tasks[status])
        end,
        hl = function()
          return {
            fg = utils.get_highlight(string.format("Overseer%s", status)).fg,
          }
        end,
      }
    end

    local Overseer = {
      condition = function()
        return package.loaded.overseer
      end,
      init = function(self)
        local tasks = require("overseer.task_list").list_tasks({ unique = true })
        local tasks_by_status = require("overseer.util").tbl_group_by(tasks, "status")
        self.tasks = tasks_by_status
      end,
      static = {
        symbols = {
          ["CANCELED"] = " ",
          ["FAILURE"] = "󰅚 ",
          ["SUCCESS"] = "󰄴 ",
          ["RUNNING"] = "󰑮 ",
        },
      },

      rpad(OverseerTasksForStatus("CANCELED")),
      rpad(OverseerTasksForStatus("RUNNING")),
      rpad(OverseerTasksForStatus("SUCCESS")),
      rpad(OverseerTasksForStatus("FAILURE")),
    }

    local Dropbar = {
      condition = function(self)
        self.data = vim.tbl_get(dropbar.bars or {}, vim.api.nvim_get_current_buf(), vim.api.nvim_get_current_win())
        return self.data
      end,
      static = { dropbar_on_click_string = "v:lua.dropbar.callbacks.buf%s.win%s.fn%s" },
      init = function(self)
        local components = self.data.components
        local children = {}
        for i, c in ipairs(components) do
          local child = {
            {
              hl = c.icon_hl,
              provider = c.icon:gsub("%%", "%%%%"),
            },
            {
              hl = function()
                local name_hl = vim.api.nvim_get_hl(0, { name = c.name_hl })
                name_hl.bold = false
                name_hl.fg = "gray"
                return name_hl
              end,
              provider = c.name:gsub("%%", "%%%%"),
            },
            on_click = {
              callback = self.dropbar_on_click_string:format(self.data.buf, self.data.win, i),
              name = "heirline_dropbar",
            },
          }
          if i < #components then
            local sep = self.data.separator
            table.insert(child, {
              provider = sep.icon,
              hl = sep.icon_hl,
              on_click = {
                callback = self.dropbar_on_click_string:format(self.data.buf, self.data.win, i + 1),
              },
            })
          end
          table.insert(children, child)
        end
        self.child = self:new(children, 1)
      end,
      provider = function(self)
        return self.child:eval()
      end,
    }

    local Lazy = {
      condition = require("lazy.status").has_updates,
      update = { "User", pattern = "LazyUpdate" },
      provider = function()
        return "  " .. require("lazy.status").updates() .. " "
      end,
      on_click = {
        callback = function()
          require("lazy").update()
        end,
        name = "update_plugins",
      },
      hl = { fg = "gray" },
    }

    local Statusline = {
      ViMode,
      Git,
      Diagnostics,
      WorkDir,
      FileNameBlock,

      Reset,
      Align,

      Overseer,
      Lazy,
      LSPActive,
      FileType,
      Ruler,
    }

    local AlphaStatusline = {
      condition = function()
        return conditions.buffer_matches({
          filetype = { "alpha" },
        })
      end,

      Reset,
    }

    local FileTreeStatusline = {
      condition = function()
        if vim.bo.filetype == "neo-tree" then
          return true
        end
        return false
      end,

      ViMode,
      Git,
      {
        utils.surround({ "", "" }, "bright_bg", {
          provider = function()
            local icon = " "
            local cwd = vim.fn.getcwd(0)
            cwd = vim.fn.fnamemodify(cwd, ":t")
            if not conditions.width_percent_below(#cwd, 0.25) then
              cwd = vim.fn.pathshorten(cwd)
            end
            return icon .. cwd
          end,
          hl = { fg = "blue", bold = true },
        }),
      },

      Align,

      FileType,
      Ruler,
    }

    local PromptStatusline = {
      condition = function()
        return conditions.buffer_matches({
          buftype = { "prompt" },
        })
      end,

      Reset,
    }

    local HelpStatusline = {
      condition = function()
        return conditions.buffer_matches({
          buftype = { "help" },
        })
      end,

      HelpFileName,

      Align,

      FileType,
    }

    local TerminalStatusLine = {
      condition = function()
        return conditions.buffer_matches({
          buftype = { "toggleterm" },
        })
      end,

      ViMode,
      WorkDir,

      Reset,
      Align,

      FileType,
    }

    local Statuslines = {
      fallthrough = false,
      AlphaStatusline,
      FileTreeStatusline,
      PromptStatusline,
      HelpStatusline,
      TerminalStatusLine,
      Statusline,
    }

    local Winbar = {
      Navic,
      Reset,
    }

    return {
      statusline = Statuslines,
      winbar = Winbar,
    }
  end,
  config = function(_, opts)
    local utils = require("heirline.utils")
    local colors = {
      bright_bg = utils.get_highlight("Folded").bg,
      bright_fg = utils.get_highlight("Folded").fg,
      red = utils.get_highlight("DiagnosticError").fg,
      dark_red = utils.get_highlight("DiffDelete").bg,
      green = utils.get_highlight("String").fg,
      blue = utils.get_highlight("Function").fg,
      gray = utils.get_highlight("NonText").fg,
      orange = utils.get_highlight("Constant").fg,
      purple = utils.get_highlight("Statement").fg,
      cyan = utils.get_highlight("Special").fg,
      diag_warn = utils.get_highlight("DiagnosticWarn").fg,
      diag_error = utils.get_highlight("DiagnosticError").fg,
      diag_hint = utils.get_highlight("DiagnosticHint").fg,
      diag_info = utils.get_highlight("DiagnosticInfo").fg,
      git_del = utils.get_highlight("diffDeleted").fg,
      git_add = utils.get_highlight("diffAdded").fg,
      git_change = utils.get_highlight("diffChanged").fg,
    }
    require("heirline").load_colors(colors)
    require("heirline").setup(opts)
  end,
}
