local M = {}

function M.config()
  local null_ls = require("null-ls")
  local builtins = null_ls.builtins

  local function on_attach(client, bufnr)
    if client.resolved_capabilities.document_formatting then
      local group = vim.api.nvim_create_augroup("null_ls_formatting", { clear = true })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = group,
        callback = function()
          vim.lsp.buf.formatting_seq_sync(nil, nil, { "null-ls" })
        end,
        buffer = bufnr,
        desc = "Format buffer with null-ls",
      })
    end
  end

  null_ls.setup({
    debounce = 250,
    diagnostics_format = "[#{s}] #{c}: #{m}",
    on_attach = on_attach,
    sources = {
      builtins.formatting.trim_whitespace,
      builtins.formatting.trim_newlines.with({
        disabled_filetypes = { "crontab" },
      }),
      -- Lua
      builtins.formatting.stylua,
      -- Python
      -- builtins.diagnostics.flake8,
      -- builtins.diagnostics.pylint.with({
      -- 	condition = function(utils)
      -- 		return utils.root_has_file(".pylintrc")
      -- 	end,
      -- }),
      -- builtins.diagnostics.mypy,
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
      -- CSS/HTML/JSON/YAML/Markdown
      builtins.diagnostics.yamllint,
      builtins.diagnostics.markdownlint.with({
        filetypes = { "markdown", "vimwiki" },
      }),
      builtins.formatting.prettier.with({
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
    },
  })
end

return M