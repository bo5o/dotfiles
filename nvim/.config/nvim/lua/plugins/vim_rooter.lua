local M = {}

function M.setup()
  vim.g.rooter_silent_chdir = 1
  vim.g.rooter_cd_cmd = "lcd"
  vim.g.rooter_patterns = {
    "!^.direnv",
    "!^site-packages",
    "!^node_modules",
    ".project-root",
    "package.json",
    "requirements.txt",
    "setup.py",
    "manage.py",
    "pyproject.toml",
    ".git",
  }
end

return M
