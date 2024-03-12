-- return {
--   "taybart/b64.nvim",
--   keys = {
--     { "<leader>cd", "<cmd>B64Decode<cr>", mode = "v", desc = "Base64 Decode " },
--     { "<leader>ce", "<cmd>B64Encode<cr>", mode = "v", desc = "Base64 encode" },
--   },
-- }

-- the following code does not properly make base64 encoding
return {
  "deponian/nvim-base64",
  version = "*",
  keys = {
    -- Decode/encode selected sequence from/to base64
    -- (mnemonic: [b]ase64)
    { "<leader>cd", "<Plug>(FromBase64)", mode = "x", desc = "Base64 Decode " },
    { "<leader>ce", "<Plug>(ToBase64)", mode = "x", desc = "Base64 encode" },
  },
  config = function()
    require("nvim-base64").setup()
  end,
}
