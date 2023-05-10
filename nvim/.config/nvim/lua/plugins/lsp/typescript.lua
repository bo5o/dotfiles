local M = {}

function M.setup(on_attach, capabilities)
  require("typescript").setup({
    disable_commands = false, -- prevent the plugin from creating Vim commands
    debug = false, -- enable debug logging for commands
    server = { -- pass options to lspconfig's setup method
      on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
      end,
      capabilities = capabilities,
      settings = {
        typescript = {
          format = {
            tabSize = 2,
            indentSize = 2,
            convertTabsToSpaces = true,
          },
        },
      },
    },
  })
end

return M
