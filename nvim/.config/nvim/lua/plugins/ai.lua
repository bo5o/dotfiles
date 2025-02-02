return {
  {
    "olimorris/codecompanion.nvim",
    cond = function()
      return vim.env.ANTHROPIC_API_KEY ~= nil
    end,
    cmd = {
      "CodeCompanion",
      "CodeCompanionChat",
      "CodeCompanionActions",
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      { "echasnovski/mini.diff", version = "*", opts = {} },
    },
    keys = {
      {
        "<leader>oa",
        "<cmd>CodeCompanionChat Toggle<cr>",
        desc = "Toggle AI chat",
        mode = { "n" },
      },
      {
        "<leader>oa",
        ":CodeCompanionChat Add<cr>",
        desc = "Send to AI chat",
        mode = { "v" },
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
      local default_adapter = "anthropic"
      return {
        strategies = {
          chat = {
            adapter = default_adapter,
            keymaps = {
              send = {
                modes = { n = "<C-s>", i = "<C-s>" },
                index = 2,
                callback = "keymaps.send",
                description = "Send",
              },
            },
            roles = {
              llm = function(adapter)
                return string.format(
                  "%s%s",
                  adapter.formatted_name,
                  adapter.parameters.model and " (" .. adapter.parameters.model .. ")"
                    or adapter.schema.model.default
                )
              end,
            },
          },
          inline = { adapter = default_adapter },
          cmd = { adapter = default_adapter },
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
