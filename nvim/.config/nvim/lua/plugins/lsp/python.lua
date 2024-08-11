local M = {}

function M.setup()
  require("lspconfig").ruff.setup({})
  require("lspconfig").basedpyright.setup({
    settings = {
      basedpyright = {
        disableOrganizeImports = true,
      },
    },
  })
end

return M
