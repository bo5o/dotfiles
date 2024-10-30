local M = {}

function M.setup()
  require("lspconfig").ocamllsp.setup({})
end

return M
