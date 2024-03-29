return {
  "nvim-telescope/telescope.nvim",
  keys = {
    -- disable the keymap to grep files
    -- {"<leader>/", false},
    -- change a keymap
    { "<leader>bf", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    { "<leader>fF", false },
    -- add a keymap to browse plugin files
    {
      "<leader>fp",
      function()
        require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
      end,
      desc = "Find Plugin File",
    },
  },
}
