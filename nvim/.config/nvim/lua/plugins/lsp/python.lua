local M = {}

function M.setup()
  require("lspconfig").pylsp.setup({
    settings = {
      pylsp = {
        configurationSources = { "flake8" },
        plugins = {
          jedi_completion = { enabled = true },
          jedi_definition = { enabled = true },
          jedi_hover = { enabled = true },
          jedi_references = { enabled = true },
          jedi_signature_help = { enabled = true },
          jedi_symbols = { enabled = true },
          black = { enabled = true },
          ruff = {
            enabled = true,
            select = { "E", "F", "I" },
          },
          mypy = {
            enabled = true,
            dmypy = true,
            strict = true,
            report_progress = true,
          },
          autopep8 = { enabled = false },
          flake8 = { enabled = false },
          isort = { enabled = false },
          preload = { enabled = true },
          mccabe = { enabled = false },
          pycodestyle = { enabled = false },
          pydocstyle = { enabled = false },
          pyflakes = { enabled = false },
          pylint = { enabled = false },
          rope_completion = { enabled = false },
          rope_autoimport = { enabled = false },
          yapf = { enabled = false },
        },
      },
    },
  })
end

return M
