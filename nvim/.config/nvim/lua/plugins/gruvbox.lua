local M = {}

function M.setup()
  local group = vim.api.nvim_create_augroup("MyColors", { clear = true })
  local highlight = function(name, val)
    vim.api.nvim_set_hl(0, name, val)
  end

  vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    group = group,
    callback = function()
      highlight("PopupWindow", { fg = "#ebdbb2", bg = "#3c3836" })
      highlight("NormalFloat", { bg = "#32302f" })
      highlight(
        "QuickScopePrimary",
        { fg = "#fe8019", bold = true, ctermfg = 155, cterm = { underline = true } }
      )
      highlight(
        "QuickScopeSecondary",
        { fg = "#d65d0e", bold = true, ctermfg = 81, cterm = { underline = true } }
      )
    end,
  })
end

function M.config()
  vim.g.gruvbox_material_foreground = "material"
  vim.g.gruvbox_material_background = "medium"
  vim.g.gruvbox_material_statusline_style = "default"
  vim.g.gruvbox_material_enable_bold = 0
  vim.g.gruvbox_material_enable_italic = 0
  vim.g.gruvbox_material_disable_italic_comment = 0
  vim.g.gruvbox_material_sign_column_background = "none"
  vim.g.gruvbox_material_better_performance = 1
  vim.g.gruvbox_material_diagnostic_line_highlight = 0
  vim.g.gruvbox_material_diagnostic_text_highlight = 1

  vim.cmd("colorscheme gruvbox-material")
end

return M
