return {
  {
    "olimorris/codecompanion.nvim",
    cond = function()
      return vim.env.ANTHROPIC_API_KEY ~= nil
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "MeanderingProgrammer/render-markdown.nvim",
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
    config = function()
      require("codecompanion").setup({
        strategies = {
          chat = {
            adapter = "anthropic",
          },
          inline = {
            adapter = "anthropic",
          },
          cmd = {
            adapter = "anthropic",
          },
        },
      })
    end,
  },
}
