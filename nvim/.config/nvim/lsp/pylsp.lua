---@type vim.lsp.Config
return {
  -- expose mypy through pylsp
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
  on_attach = function(client)
    -- stop server if mypy is not available in the current virtual environment
    local mypy_available = vim.env.VIRTUAL_ENV
      and vim.uv.fs_stat(vim.fs.joinpath(vim.env.VIRTUAL_ENV, "bin", "mypy"))
    if not mypy_available then
      client:stop()
    end
  end,
}
