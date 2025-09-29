vim.api.nvim_create_autocmd("FileType", {
  pattern = { "yaml", "python" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.expandtab = true
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    vim.cmd([[
      autocmd FileType python,yaml setlocal shiftwidth=2 tabstop=2 expandtab
    ]])
  end,
})
