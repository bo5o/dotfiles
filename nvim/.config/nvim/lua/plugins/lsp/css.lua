local M = {}

function M.setup(capabilities)
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  require("lspconfig").cssls.setup({
    capabilities = capabilities,
  })
end

return M
