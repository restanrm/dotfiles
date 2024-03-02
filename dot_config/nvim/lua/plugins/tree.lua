return {
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },

  {
    "nvim-tree/nvim-tree.lua",
    keys = {
      { "<leader>tt", "<cmd>NvimTreeToggle<cr>", desc = "Toggle tree navigation" },
      { "<leader>tf", "<cmd>NvimTreeFindFile<cr>", desc = "Find current file in tree" },
    },
    opts = function()
      return {
        sort_by = "case_sensitive",
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = true,
        },
      }
    end,
  },
}
