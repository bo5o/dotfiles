local M = {}

function M.setup()
  require("lspconfig").jsonls.setup({
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
      },
    },
  })
end

return M
