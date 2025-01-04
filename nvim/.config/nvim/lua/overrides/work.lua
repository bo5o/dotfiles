return {
  -- Generate token with `:Copilot auth`
  { "github/copilot.vim", cmd = "Copilot" },
  {
    "olimorris/codecompanion.nvim",
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
