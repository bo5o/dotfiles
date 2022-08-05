local M = {}

function M.config()
  -- require("aerial").on_attach(client, bufnr)
  require("aerial").setup({
    backends = { "lsp", "treesitter" },
    filter_kind = false,
  })
end

return M
