local M = {}

function M.setup(on_attach, capabilities)
  local rt = require("rust-tools")

  rt.setup({
    server = {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        ["rust-analyzer"] = {
          checkOnSave = {
            command = "clippy",
            extraArgs = { "--no-deps" },
          },
        },
      },
    },
  })
end

return M
