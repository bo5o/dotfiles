return {
  -- Generate token for copilot with `:Copilot auth`
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    config = function()
      require("copilot").setup({
        panel = { enabled = false },
        suggestion = { enabled = false },
        filetype = { ["*"] = false },
      })
    end,
  },
  {
    "ravitemer/mcphub.nvim",
    keys = {
      { "<leader>om", "<cmd>MCPHub<cr>", desc = "Open MCP hub" },
    },
    opts = {},
  },
  {
    "olimorris/codecompanion.nvim",
    cmd = {
      "CodeCompanion",
      "CodeCompanionChat",
      "CodeCompanionActions",
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
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
      local default_adapter = vim.env.ANTHROPIC_API_KEY ~= nil and "anthropic"
        or "copilot"
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
        adapters = {
          copilot = function()
            return require("codecompanion.adapters").extend("copilot", {
              schema = {
                model = {
                  default = "claude-sonnet-4",
                },
              },
            })
          end,
        },
        extensions = {
          mcphub = {
            callback = "mcphub.extensions.codecompanion",
            opts = {
              show_result_in_chat = true,
              make_vars = true,
              make_slash_commands = true,
            },
          },
        },
      }
    end,
  },
}
