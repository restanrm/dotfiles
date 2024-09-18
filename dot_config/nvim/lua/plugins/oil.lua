return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    { '<leader>o',
    function()
      require('oil').open()
    end,
    desc = '[F]ormat buffer', },
    {'-', "<CMD>Oil<CR>", desc="Open parent directory" }
  },
  opts = {
    default_file_explorer = true,
    view_options = {
      show_hidden = false,
    },
  },
  lazy = false,
}
