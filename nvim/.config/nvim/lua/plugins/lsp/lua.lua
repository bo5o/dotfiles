local M = {}

function M.setup()
  require("neodev").setup({
    library = {
      runtime = true,
      types = true,
      plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
    },
    lspconfig = false,
  })

  require("lspconfig").lua_ls.setup({
    before_init = require("neodev.lsp").before_init,
    settings = {
      Lua = {
        format = { enable = false },
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
