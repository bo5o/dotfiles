local M = {}

function M.setup()
  vim.g.miniindentscope_disable = true
end

function M.config()
  require("mini.indentscope").setup({
    mappings = {
      -- Textobjects
      object_scope = "ii",
      object_scope_with_border = "ai",

      -- Motions (jump to respective border line; if not present - body line)
      goto_top = "",
      goto_bottom = "",
    },
    options = {
      border = "none",
    },
  })

  require("mini.bufremove").setup({
    set_vim_settings = false,
  })
end

return M
