return {
  {
    "olimorris/codecompanion.nvim",
    cond = function()
      return vim.env.NEOVIM_CONTEXT == "work"
    end,
    dependencies = {
      -- Generate token with `:Copilot auth`
      { "github/copilot.vim", cmd = "Copilot" },
    },
    opts = function()
      local adapter = "copilot"
      return {
        strategies = {
          chat = { adapter = adapter },
          inline = { adapter = adapter },
          cmd = { adapter = adapter },
        },
        adapters = {
          copilot = function()
            return require("codecompanion.adapters").extend("copilot", {
              schema = {
                model = {
                  default = "claude-3.5-sonnet",
                },
              },
            })
          end,
          opts = {
            proxy = "localhost:3128", -- start with `proxy -d`
          },
        },
      }
    end,
  },
}
