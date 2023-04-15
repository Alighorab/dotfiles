local function getcwd()
  return "%=" .. vim.fn.getcwd()
end

local function get_icon(name, extension)
  local icon, color
  if name == "Makefile" then
    icon, color = require("nvim-web-devicons").get_icon("makefile", "", {})
  else
    icon, color = require("nvim-web-devicons").get_icon(name, extension, {})
  end
  return icon, color
end

local function filename()
  local icon, color = get_icon(vim.fn.expand("%:t"), vim.fn.expand("%:e"))
  local fn = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.")
  if icon and color then
    return "%=" .. icon .. " " .. fn .. " %m"
  else
    return "%=" .. fn .. "%m"
  end
end

local extention = {
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = { getcwd },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  filetypes = {
    "NvimTree",
    "TelescopePrompt",
  },
}

local toggleterm = {
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = {},
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  filetypes = {
    "toggleterm",
  },
}

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "catppuccin",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = true,
  },
  tabline = {
    lualine_a = {
      {
        "buffers",
        show_filename_only = false,
        symbols = { modified = " ●", alternate_file = "", directory = "" },
        filetype_names = {
          TelescopePrompt = "Telescope",
          fugitive = "Fugitive",
          git = "git",
          lazy = "Lazy",
          mason = "Mason",
          NvimTree = "Explorer",
        },
      },
    },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  sections = {
    lualine_c = { },
  },
  extensions = {
    extention,
    toggleterm,
  },
})