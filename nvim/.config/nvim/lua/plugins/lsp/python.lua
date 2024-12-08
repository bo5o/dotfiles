local M = {}

function M.setup()
  require("lspconfig").ruff.setup({})

  require("lspconfig").basedpyright.setup({
    settings = {
      basedpyright = {
        disableOrganizeImports = true,
      },
    },
  })

  -- expose mypy through pylsp
  require("lspconfig").pylsp.setup({
    autostart = false,
    settings = {
      pylsp = {
        plugins = {
          -- enable mypy daemon
          mypy = {
            enabled = true,
            dmypy = true,
            strict = true,
            report_progress = true,
          },

          -- disable all other plugins
          jedi_completion = { enabled = false },
          jedi_definition = { enabled = false },
          jedi_hover = { enabled = false },
          jedi_references = { enabled = false },
          jedi_signature_help = { enabled = false },
          jedi_symbols = { enabled = false },
          autopep8 = { enabled = false },
          flake8 = { enabled = false },
          mccabe = { enabled = false },
          preload = { enabled = false },
          pycodestyle = { enabled = false },
          pydocstyle = { enabled = false },
          pyflakes = { enabled = false },
          pylint = { enabled = false },
          rope_autoimport = { enabled = false },
          rope_completion = { enabled = false },
          yapf = { enabled = false },
        },
      },
    },
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function(opt)
      ---@type vim.lsp.Client|nil
      local client = nil
      for _, item in ipairs(vim.lsp.get_clients()) do
        if item.name == "pylsp" then
          client = item
          break
        end
      end
      local condition = vim.env.VIRTUAL_ENV
        and vim.fn.filereadable(vim.fs.joinpath(vim.env.VIRTUAL_ENV, "bin", "mypy"))
          == 1
      if condition then
        if client then
          vim.lsp.buf_attach_client(opt.buf, client.id)
        else
          require("lspconfig.configs")["pylsp"].launch()
        end
      end
    end,
  })
end

return M
