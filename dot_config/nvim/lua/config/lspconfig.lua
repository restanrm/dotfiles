require("lspconfig").ruff_lsp.setup({
  init_options = {
    settings = {
      args = { "--preview", "--line-length=119" },
    },
  },
})
