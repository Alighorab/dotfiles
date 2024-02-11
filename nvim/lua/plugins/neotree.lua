return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    {
      -- only needed if you want to use the commands with "_with_window_picker" suffix
      "s1n7ax/nvim-window-picker",
      config = function()
        require("window-picker").setup({
          autoselect_one = true,
          include_current = false,
          filter_rules = {
            -- filter using buffer options
            bo = {
              -- if the file type is one of following, the window will be ignored
              filetype = { "neo-tree", "neo-tree-popup", "notify" },

              -- if the buffer type is one of following, the window will be ignored
              buftype = { "terminal", "quickfix" },
            },
          },
          other_win_hl_color = "#e35e4f",
        })
      end,
    },
  },
  config = function()
    -- Unless you are still migrating, remove the deprecated commands from v1.x
    vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

    require("neo-tree").setup({
      event_handlers = {
        {
          event = "file_opened",
          handler = function(_)
            require("neo-tree").close_all()
          end,
        },
      },
      close_if_last_window = true,  -- Close Neo-tree if it is the last window left in the tab
      use_default_mappings = false,
      enable_opened_markers = true, -- Enable tracking of opened files. Required for `components.name.highlight_opened_files`
      default_component_configs = {
        name = {
          highlight_opened_files = true, -- Requires `enable_opened_markers = true`.
          -- Take values in { false (no highlight), true (only loaded),
          -- "all" (both loaded and unloaded)}. For more information,
          -- see the `show_unloaded` config of the `buffers` source.
          use_git_status_colors = false,
          highlight = "NeoTreeFileName",
        },
        git_status = {
          symbols = {
            -- Change type
            added = "A",    -- or "✚", but this is redundant info if you use git_status_colors on the name
            modified = "M", -- or "", but this is redundant info if you use git_status_colors on the name
            deleted = "D",  -- this can only be used in the git_status source
            renamed = "R",  -- this can only be used in the git_status source
            -- Status type
            untracked = "U",
            ignored = "I",
            unstaged = "",
            staged = "S",
            conflict = "C",
          },
        },
      },
      window = {
        position = "left",
        width = 40,
        mapping_options = {
          noremap = true,
          nowait = true,
        },
        mappings = {
          ["<bs>"] = "navigate_up",
          ["."] = "set_root",
          ["zh"] = "toggle_hidden",
          ["F"] = "fuzzy_finder_directory",
          ["f"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
          ["[g"] = "prev_git_modified",
          ["]g"] = "next_git_modified",
          ["<cr>"] = "open",
          ["l"] = "open",
          ["<esc>"] = "revert_preview",
          ["<tab>"] = { "toggle_preview", config = { use_float = true } },
          ["S"] = "open_split",
          ["s"] = "open_vsplit",
          ["C"] = "close_node",
          ["W"] = "close_all_nodes",
          ["E"] = "expand_all_nodes",
          ["a"] = {
            "add",
            -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
            -- some commands may take optional config options, see `:h neo-tree-mappings` for details
            config = {
              show_path = "relative", -- "none", "relative", "absolute"
            },
          },
          ["A"] = {
            "add_directory",
            -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
            config = {
              show_path = "relative",
            },
          },
          ["d"] = "delete",
          ["r"] = "rename",
          ["y"] = "copy_to_clipboard",
          ["x"] = "cut_to_clipboard",
          ["p"] = "paste_from_clipboard",
          ["c"] = {
            "copy",
            config = {
              show_path = "relative", -- "none", "relative", "absolute"
            },
          },
          ["m"] = {
            "move",
            config = {
              show_path = "relative", -- "none", "relative", "absolute"
            },
          },
          ["q"] = "close_window",
          ["R"] = "refresh",
          ["?"] = "show_help",
          ["<"] = "prev_source",
          [">"] = "next_source",
        },
      },
      filesystem = {
        filtered_items = {
          show_hidden_count = false, -- when true, the number of hidden items in each folder will be shown as the last entry
        },
        components = {
          harpoon_index = function(config, node, _)
            local Marked = require("harpoon.mark")
            local path = node:get_id()
            local succuss, index = pcall(Marked.get_index_of, path)
            if succuss and index and index > 0 then
              return {
                text = string.format(" ⥤ %d", index), -- <-- Add your favorite harpoon like arrow here
                highlight = config.highlight or "NeoTreeDirectoryIcon",
              }
            else
              return {}
            end
          end,
        },
        renderers = {
          file = {
            { "icon" },
            { "name",         use_git_status_colors = false },
            { "harpoon_index" }, --> This is what actually adds the component in where you want it
            { "diagnostics" },
            { "git_status",   highlight = "NeoTreeDimText" },
          },
          name = {
            use_git_status_colors = false,
          },
        },
        group_empty_dirs = true,       -- when true, empty folders will be grouped together
        use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
        window = {
          mappings = {
            ["<bs>"] = "navigate_up",
            ["."] = "set_root",
            ["zh"] = "toggle_hidden",
            ["F"] = "fuzzy_finder_directory",
            ["f"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
            ["<esc>"] = "clear_filter",
            ["[g"] = "prev_git_modified",
            ["]g"] = "next_git_modified",
          },
          fuzzy_finder_mappings = {
            ["<down>"] = "move_cursor_down",
            ["<C-d>"] = "move_cursor_down",
            ["<up>"] = "move_cursor_up",
            ["<C-u>"] = "move_cursor_up",
          },
        },
      },
    })

    vim.keymap.set("n", "<leader>e", ":Neotree toggle<cr>", { desc = "Toggle Neo-tree" })
  end,
  enabled = true,
}
