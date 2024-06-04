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
        schemaStore = {
          enable = false,
          url = "",
        },
        schemas = require("schemastore").yaml.schemas(),
        format = {
          enable = false,
        },
      },
    },
  })
end

return M
