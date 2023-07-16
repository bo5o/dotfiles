local M = {}

function M.setup()
  require("lspconfig").jsonls.setup({
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        format = { enable = true },
        validate = { enable = true },
      },
    },
  })
end

return M
