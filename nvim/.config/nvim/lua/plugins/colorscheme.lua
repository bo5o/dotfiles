return {
  {
    "sainnhe/gruvbox-material",
    init = function()
      local group = vim.api.nvim_create_augroup("MyColors", { clear = true })
      local highlight = function(name, val)
        vim.api.nvim_set_hl(0, name, val)
      end

      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        group = group,
        callback = function()
          highlight("PopupWindow", { fg = "#d4be98", bg = "#282828" })
          highlight("NormalFloat", { bg = "#282828" })
          highlight("TreesitterContext", { link = "Normal" })
          highlight("TreesitterContextSeparator", { link = "IblIndent" })
          highlight(
            "QuickScopePrimary",
            { fg = "#fe8019", bold = true, ctermfg = 155, cterm = { underline = true } }
          )
          highlight(
            "QuickScopeSecondary",
            { fg = "#d65d0e", bold = true, ctermfg = 81, cterm = { underline = true } }
          )
          highlight("FloatBorder", { ctermfg = nil, ctermbg = nil, cterm = nil })
          highlight(
            "FloatermBorder",
            { fg = "#ebdbb2", bg = nil, ctermfg = 0, ctermbg = 13 }
          )
          highlight("DiagnosticUnnecessary", { link = "Comment" })
          highlight(
            "ScrollViewCursor",
            { fg = "#7daea3", bg = "#45403d", ctermfg = 109 }
          )
          highlight("CmpItemMenu", { fg = "#928374", ctermfg = 245 })

          highlight("DiffDelete", { fg = "#444444" })
          highlight("DiffText", { bg = "#374141", ctermbg = 23 })
        end,
      })

      vim.g.gruvbox_material_foreground = "material"
      vim.g.gruvbox_material_background = "medium"
      vim.g.gruvbox_material_statusline_style = "default"
      vim.g.gruvbox_material_enable_bold = 0
      vim.g.gruvbox_material_enable_italic = 0
      vim.g.gruvbox_material_disable_italic_comment = 0
      vim.g.gruvbox_material_sign_column_background = "none"
      vim.g.gruvbox_material_better_performance = 1
      vim.g.gruvbox_material_diagnostic_line_highlight = 0
      vim.g.gruvbox_material_diagnostic_text_highlight = 0
      vim.g.gruvbox_material_inlay_hints_background = "none"
    end,
    config = function()
      vim.cmd("colorscheme gruvbox-material")
    end,
  },
}
