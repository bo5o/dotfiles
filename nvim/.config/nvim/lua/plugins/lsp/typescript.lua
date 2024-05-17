local M = {}

function M.setup(capabilities)
  require("typescript").setup({
    disable_commands = false, -- prevent the plugin from creating Vim commands
    debug = false, -- enable debug logging for commands
    server = { -- pass options to lspconfig's setup method
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
