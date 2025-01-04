return {
  {
    "olimorris/codecompanion.nvim",
    cond = function()
      return vim.env.ANTHROPIC_API_KEY ~= nil
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "MeanderingProgrammer/render-markdown.nvim",
      { "echasnovski/mini.diff", version = "*" },
    },
    keys = {
      {
        "<leader>oa",
        "<cmd>CodeCompanionChat Toggle<cr>",
        desc = "Toggle AI chat",
        mode = { "n" },
      },
      {
        "cra",
        "<cmd>CodeCompanionActions<cr>",
        desc = "Select AI action",
        mode = { "n" },
      },
      {
        "<c-r>a",
        "<cmd>CodeCompanionActions<cr>",
        desc = "Select AI action",
        mode = { "v" },
      },
      {
        "crc",
        ":CodeCompanion<space>",
        desc = "Code companion",
        mode = { "n" },
      },
      {
        "<c-r>c",
        ":CodeCompanion<space>",
        desc = "Code companion",
        mode = { "v" },
      },
    },
    opts = function()
      local adapter = "anthropic"
      return {
        strategies = {
          chat = { adapter = adapter },
          inline = { adapter = adapter },
          cmd = { adapter = adapter },
        },
        display = {
          diff = {
            provider = "mini_diff",
          },
        },
      }
    end,
  },
}
