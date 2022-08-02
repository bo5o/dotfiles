local M = {}

function M.setup()
  vim.cmd([[function! StartStrategy(cmd)
    execute 'Start -wait=always ' . a:cmd
endfunction
]])

  vim.g["test#custom_strategies"] = { start = vim.fn["StartStrategy"] }
  vim.g["test#strategy"] = "start"

  vim.g["test#filename_modifier"] = ":p"

  -- Python
  vim.g["test#python#pytest#file_pattern"] = "\\.py"
  vim.g["test#python#runner"] = "pytest"

  vim.g["test#python#pytest#options"] = {
    nearest = "--pdb --pdbcls=IPython.terminal.debugger:TerminalPdb --no-cov",
    file = "--no-cov",
  }

  -- JavaScript
  vim.g["test#javascript#runner"] = "jest"
end

return M
