local M = {}

function M.setup(capabilities)
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  require("lspconfig").html.setup({
    capabilities = capabilities,
  })
end

return M
