local M = {}

function M.config()
  -- require("aerial").on_attach(client, bufnr)
  require("aerial").setup({
    backends = {
      ["_"] = { "lsp", "treesitter" },
      python = { "lsp" },
    },
    filter_kind = {
      ["_"] = false,
      python = {
        -- "Array",
        -- "Boolean",
        "Class",
        -- "Constant",
        "Constructor",
        "Enum",
        "EnumMember",
        -- "Event",
        -- "Field",
        -- "File",
        "Function",
        "Interface",
        -- "Key",
        "Method",
        "Module",
        -- "Namespace",
        -- "Null",
        -- "Number",
        -- "Object",
        -- "Operator",
        -- "Package",
        "Property",
        -- "String",
        "Struct",
        -- "TypeParameter",
        -- "Variable",
      },
    },
    ignore = {
      filetypes = {
        "startify",
      },
    },
  })
end

return M
