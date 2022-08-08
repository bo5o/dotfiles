local M = {}

function M.setup()
  local g = vim.g
  g["airline#extensions#ale#enabled"] = 1
  g.ale_virtualtext_cursor = 1
  g.ale_lint_on_text_changed = 0
  g.ale_lint_on_save = 1
  g.ale_lint_on_enter = 1
  g.ale_fix_on_save = 1
  g.ale_set_loclist = 0
  g.ale_set_quickfix = 1
  g.ale_echo_msg_format = "[%linter%] %code%: %s"
  g.ale_sign_error = ""
  g.ale_sign_warning = ""
  g.ale_sign_info = ""
  g.ale_disable_lsp = 1

  g.ale_pattern_options = {
    ["\\.min\\.js$"] = { ale_linters = {}, ale_fixers = {} },
    ["\\.min\\.css$"] = { ale_linters = {}, ale_fixers = {} },
    [".git/(?!COMMIT_EDITMSG)$"] = { ale_linters = {}, ale_fixers = {} },
    ["site-packages/.*$"] = { ale_linters = {}, ale_fixers = {} },
    ["node_modules/.*$"] = { ale_linters = {}, ale_fixers = {} },
  }
  g.ale_pattern_options_enabled = 1

  g.ale_linters = {
    Dockerfile = {},
    gitcommit = { "gitlint" },
    javascript = {},
    json = { "jsonlint" },
    python = { "flake8", "mypy", "pylint" },
    sh = { "bashate" },
    sql = { "sqlint" },
    tex = {},
    markdown = {},
    vimwiki = {},
    typescript = {},
    vim = {},
    vue = {},
    xml = {},
    yaml = {},
    zsh = {},
  }

  g.ale_fixers = {
    css = {},
    html = {},
    markdown = {},
    htmldjango = { "html-beautify" },
    javascript = {},
    json = {},
    go = {},
    sh = {},
    sql = {},
    tex = { "latexindent" },
    typescript = {},
    vue = {},
    yaml = {},
  }
end

return M
