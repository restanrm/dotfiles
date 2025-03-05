require("lspconfig").ruff.setup({
  init_options = {
    settings = {
      args = { "--preview", "--line-length=119" },
    },
  },
})
