local M = {}

function M.config()
  require("todo-comments").setup({
    colors = {
      error = { "DiagnosticError", "ErrorMsg", "#ea6962" },
      warning = { "DiagnosticWarn", "WarningMsg", "#d8a657" },
      info = { "DiagnosticInfo", "#7daea3" },
      hint = { "DiagnosticHint", "#a9b665" },
      default = { "Identifier", "#7daea3" },
      test = { "Identifier", "#7daea3" },
    },
  })
end

return M
