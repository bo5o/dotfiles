local M = {}

function M.setup(on_attach)
  require("lspconfig").volar.setup({
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
    end,
  })
end

return M
