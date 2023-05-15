return {
  "ThePrimeagen/harpoon",
  keys = {
    {
      "<leader>hm",
      function()
        require("harpoon.mark").add_file()
      end,
      desc = "Harppon Add File",
    },
    {
      "<leader>hu",
      function()
        require("harpoon.ui").toggle_quick_menu()
      end,
      desc = "Harppon Quick Menu Toggle",
    },
    {
      "<C-j>",
      function()
        require("harpoon.ui").nav_file(1)
      end,
      desc = "Harppon Navigate File (1)",
    },
    {
      "<C-f>",
      function()
        require("harpoon.ui").nav_file(2)
      end,
      desc = "Harppon Navigate File (2)",
    },
    {
      "<C-h>",
      function()
        require("harpoon.ui").nav_file(3)
      end,
      desc = "Harppon Navigate File (3)",
    },
    {
      "<C-g>",
      function()
        require("harpoon.ui").nav_file(4)
      end,
      desc = "Harppon Navigate File (4)",
    },
  },
}
