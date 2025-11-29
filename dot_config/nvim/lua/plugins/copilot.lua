return {
  {
    "github/copilot.vim",
    enabled = false, -- copilot is disabled by default
    keys = {
      {
        "<leader>ct",
        function()
          if vim.g.copilot_enabled == 1 then
            vim.g.copilot_enabled = 0
            vim.cmd("Copilot disable")
          else
            vim.g.copilot_enabled = 1
            vim.cmd("Copilot enable")
          end
        end,
        desc = "Toggle GitHub Copilot",
        mode = { "n", "v" },
      },
    },
  },
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   build = ":Copilot auth",
  --   event = "BufReadPost",
  --   opts = {
  --     suggestion = {
  --       enabled = not vim.g.ai_cmp,
  --       auto_trigger = true,
  --       hide_during_completion = vim.g.ai_cmp,
  --       keymap = {
  --         accept = false, -- handled by nvim-cmp / blink.cmp
  --         next = "<M-]>",
  --         prev = "<M-[>",
  --       },
  --     },
  --     panel = { enabled = false },
  --     filetypes = {
  --       markdown = true,
  --       help = true,
  --     },
  --   },
  -- },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    cmd = "CopilotChat",
    -- opts = function()
    --   local user = vim.env.USER or "User"
    --   user = user:sub(1, 1):upper() .. user:sub(2)
    --   return {
    --     auto_insert_mode = true,
    --     question_header = "  " .. user .. " ",
    --     answer_header = "  Copilot ",
    --     window = {
    --       width = 0.4,
    --     },
    --   }
    -- end,
    opts = {
      prompts = {
        CustomCommit = {
          prompt = "Write commit message for change with commitizen convention. Keep the title under 50 characters and wrap message at 72 characters. Format as a gitcommit code block.",
          resources = {
            "gitstatus",
          },
        },
      },
    },

    keys = {
      { "<c-s>", "<CR>", ft = "copilot-chat", desc = "Submit Prompt", remap = true },
      { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
      { "<leader>ae", ":CopilotChatExplain<CR>", desc = "Explain Code" },
      { "<leader>ac", ":CopilotChatCustomCommit<CR>", desc = "Generate commit description" },
      { "<leader>at", ":CopilotChatTests<CR>", desc = "Generate Tests" },
      { "<leader>ad", ":CopilotChatDocs<CR>", desc = "Generate documentation" },
      {
        "<leader>aa",
        function()
          return require("CopilotChat").toggle()
        end,
        desc = "Toggle (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>ax",
        function()
          return require("CopilotChat").reset()
        end,
        desc = "Clear (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>aq",
        function()
          vim.ui.input({
            prompt = "Quick Chat: ",
          }, function(input)
            if input ~= "" then
              require("CopilotChat").ask(input)
            end
          end)
        end,
        desc = "Quick Chat (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>ap",
        function()
          require("CopilotChat").select_prompt()
        end,
        desc = "Prompt Actions (CopilotChat)",
        mode = { "n", "v" },
      },
    },
  },
}
