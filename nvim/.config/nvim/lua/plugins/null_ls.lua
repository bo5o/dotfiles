local M = {}

local Path = require("plenary.path")

local function search_upwards(file, opts)
  local start = Path:new(opts.start_from or vim.fn.expand("%"))
  local stop = Path:new(opts.stop_at or vim.fn.expand("~"))

  for _, dir in pairs(start:parents()) do
    local config_file = Path:new(dir) / file

    if config_file:is_file() then
      return tostring(config_file)
    end

    if dir == tostring(stop) then
      return nil
    end
  end
end

local function from_virtual_env(params)
  local venv = vim.env.VIRTUAL_ENV
  local command = nil
  if venv then
    command = tostring(Path:new(venv) / "bin" / params.command)
  end
  return command
end

function M.config()
  local null_ls = require("null-ls")
  local builtins = null_ls.builtins

  local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })

  local function on_attach(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
        desc = "Format buffer on save, using null-ls last",
      })
    end
  end

  null_ls.setup({
    debug = false,
    debounce = 250,
    diagnostics_format = "[#{s}] #{c}: #{m}",
    on_attach = on_attach,
    should_attach = function(bufnr)
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      return not bufname:match("%.min%.css$")
        and not bufname:match("%.min%.js$")
        and not (bufname:match("%.git/.+$") and not bufname:match("COMMIT_EDITMSG$"))
        and not bufname:match("site%-packages/.+$")
        and not bufname:match("node_modules/.+$")
    end,
    sources = {
      builtins.formatting.trim_whitespace,
      builtins.formatting.trim_newlines.with({
        disabled_filetypes = { "crontab" },
      }),
      -- Rust
      builtins.formatting.rustfmt,
      -- Lua
      builtins.formatting.stylua,
      -- Gitcommit
      builtins.diagnostics.gitlint,
      -- Python
      builtins.diagnostics.pylint.with({
        method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
        condition = function(utils)
          return utils.root_has_file(".pylintrc")
        end,
        dynamic_command = function(params)
          return from_virtual_env(params)
            or vim.fn.executable(params.command) == 1 and params.command
        end,
      }),
      builtins.diagnostics.flake8.with({
        method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
        dynamic_command = function(params)
          return from_virtual_env(params)
            or vim.fn.executable(params.command) == 1 and params.command
        end,
      }),
      builtins.diagnostics.mypy.with({
        method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
        timeout = 10000,
        dynamic_command = function(params)
          return from_virtual_env(params)
            or vim.fn.executable(params.command) == 1 and params.command
        end,
      }),
      builtins.formatting.black,
      builtins.formatting.isort,
      -- Javascript/Typescript/Vue
      builtins.diagnostics.eslint_d.with({
        filetypes = { "javascript", "typescript", "vue" },
        prefer_local = "node_modules/.bin",
      }),
      builtins.formatting.eslint_d.with({
        filetypes = { "javascript", "typescript", "vue" },
        prefer_local = "node_modules/.bin",
      }),
      builtins.code_actions.eslint_d.with({
        filetypes = { "javascript", "typescript", "vue" },
        prefer_local = "node_modules/.bin",
      }),
      require("typescript.extensions.null-ls.code-actions"),
      -- SQL
      builtins.diagnostics.sqlfluff.with({
        method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
        extra_filetypes = { "jinja" },
        condition = function(utils)
          return utils.root_has_file({ ".sqlfluff" })
        end,
        to_stdin = false,
        timeout = 10000,
        dynamic_command = function(params)
          return from_virtual_env(params)
            or vim.fn.executable(params.command) == 1 and params.command
        end,
        args = {
          "lint",
          "-f",
          "github-annotation",
          "-n",
          "--disable_progress_bar",
          "$FILENAME",
        },
      }),
      builtins.formatting.sql_formatter.with({
        extra_args = function(params)
          local config = search_upwards(".sql-formatter.json", {
            start_from = params.bufname,
            stop_at = params.root,
          })
          return config and { "--config", config } or {}
        end,
        prefer_local = "node_modules/.bin",
      }),
      -- CSS/HTML/JSON/YAML/Markdown
      builtins.diagnostics.yamllint,
      builtins.diagnostics.markdownlint.with({
        filetypes = { "markdown", "vimwiki" },
      }),
      builtins.formatting.prettierd.with({
        filetypes = { "css", "html", "json", "yaml", "markdown" },
      }),
      -- Dockerfile
      builtins.diagnostics.hadolint,
      -- Shell
      builtins.diagnostics.shellcheck.with({
        filetypes = { "sh", "zsh" },
      }),
      builtins.formatting.shfmt,
      -- Go
      builtins.formatting.gofmt,
      -- Tex
      builtins.diagnostics.chktex,
      builtins.formatting.latexindent,
    },
  })
end

return M
