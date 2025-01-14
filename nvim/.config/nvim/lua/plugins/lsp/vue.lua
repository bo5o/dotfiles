local M = {}

function M.setup()
  require("lspconfig").volar.setup({
    init_options = {
      vue = {
        hybridMode = true,
      },
    },
  })
end

return M
