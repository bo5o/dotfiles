local M = {}

function M.setup()
  require("lspconfig").jedi_language_server.setup({
    init_options = {
      diagnostics = { enable = false },
    },
  })
end

return M
