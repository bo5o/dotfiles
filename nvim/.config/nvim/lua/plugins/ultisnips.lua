local M = {}

function M.setup()
  vim.g.UltiSnipsExpandTrigger = "<Plug>(ultisnips_expand)"
  vim.g.UltiSnipsJumpForwardTrigger = "<Plug>(ultisnips_jump_forward)"
  vim.g.UltiSnipsJumpBackwardTrigger = "<Plug>(ultisnips_jump_backward)"
  vim.g.UltiSnipsListSnippets = "<c-x><c-s>"
  vim.g.UltiSnipsRemoveSelectModeMappings = 0
  vim.g.ultisnips_python_style = "numpy"
end

return M