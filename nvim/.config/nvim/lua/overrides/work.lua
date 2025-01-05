return {
  -- Generate token with `:Copilot auth`
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
