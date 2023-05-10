local M = {}

function M.setup()
  require("lspconfig").yamlls.setup({
    settings = {
      redhat = {
        telemetry = {
          enabled = false,
        },
      },
      yaml = {
        hover = true,
        completion = true,
        validate = true,
        schemas = require("schemastore").json.schemas(),
        format = {
          enable = false,
        },
      },
    },
  })
end

return M
