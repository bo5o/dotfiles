local M = {}

function M.setup()
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
