local M = {}

function M.setup()
  require("neodev").setup({
    library = {
      plugins = {
        "nvim-treesitter",
        "plenary.nvim",
        "telescope.nvim",
        "neotest",
      },
    },
  })

  require("lspconfig").lua_ls.setup({
    settings = {
      Lua = {
        workspace = {
          ignoreDir = { "undodir/**/*.lua" },
          checkThirdParty = false,
        },
        telemetry = { enable = false },
      },
    },
  })
end

return M
