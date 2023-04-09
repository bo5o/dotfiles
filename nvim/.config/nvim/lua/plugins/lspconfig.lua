local M = {}

function M.config()
  local mason = require("mason")
  local mason_lspconfig = require("mason-lspconfig")
  local lspconfig = require("lspconfig")
  local cmp_nvim_lsp = require("cmp_nvim_lsp")
  local lsp_signature = require("lsp_signature")
  local fidget = require("fidget")
  require("aerial")

  local function bind_map(default_opts)
    return function(lhs, rhs, desc)
      local opts = vim.tbl_extend("force", default_opts, { desc = desc })
      vim.keymap.set("n", lhs, rhs, opts)
    end
  end

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(args)
      local buf_map = bind_map({ buffer = args.buf, silent = true })
      local lsp = vim.lsp.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)

      buf_map("gd", lsp.definition, "Go to definition")
      buf_map("gD", lsp.declaration, "Go to declaration")
      buf_map("K", lsp.hover, "Display hover information")
      buf_map("gi", lsp.implementation, "List implementations")
      buf_map("gr", "<cmd>TroubleToggle lsp_references<CR>", "List all references")
      buf_map("<leader>K", lsp.signature_help, "Display signature help")
      buf_map("<leader>ld", lsp.type_definition, "Go to type definition")
      buf_map("<leader>lf", lsp.format, "Format current buffer")
      buf_map("<leader>ln", lsp.rename, "Rename all references")
      buf_map("<leader>lc", lsp.code_action, "Select code action")
      buf_map("<leader>lwa", lsp.add_workspace_folder, "Add workspace folder")
      buf_map("<leader>lwr", lsp.remove_workspace_folder, "Remove workspace folder")
      buf_map("<leader>lwl", function()
        print(vim.inspect(lsp.list_workspace_folders()))
      end, "List workspace folders")
    end,
  })

  local function create_capabilities()
    return vim.tbl_deep_extend(
      "force",
      vim.lsp.protocol.make_client_capabilities(),
      cmp_nvim_lsp.default_capabilities()
    )
  end

  local diagnostic = vim.diagnostic

  diagnostic.config({
    virtual_text = {
      source = "always",
    },
    virtual_lines = false,
    float = {
      border = "rounded",
      source = "always",
    },
  })

  local map = bind_map({ silent = true })
  map("[d", diagnostic.goto_prev, "Go to previous diagnostic")
  map("]d", diagnostic.goto_next, "Go to next diagnostic")
  map("<leader>lq", diagnostic.setloclist, "Add diagnostics to location list")
  map("<leader>lg", diagnostic.open_float, "Show diagnostics")

  ---@diagnostic disable-next-line: unused-local
  local on_attach = function(client, bufnr)
    -- highlight symbol under cursor
    -- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization
    if client.server_capabilities.documentHighlightProvider then
      for _, name in ipairs({ "Read", "Text", "Write" }) do
        vim.api.nvim_set_hl(
          0,
          "LspReference" .. name,
          { bg = "#3c3836", bold = true, cterm = { bold = true } }
        )
      end

      vim.api.nvim_create_augroup("lsp_document_highlight", {
        clear = false,
      })
      vim.api.nvim_clear_autocmds({
        buffer = bufnr,
        group = "lsp_document_highlight",
      })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        group = "lsp_document_highlight",
        buffer = bufnr,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        group = "lsp_document_highlight",
        buffer = bufnr,
        callback = vim.lsp.buf.clear_references,
      })
    end

    -- Configure signature help for completion
    lsp_signature.on_attach({
      bind = true,
      hint_enable = false,
      hi_parameter = "Search",
    })
  end

  lspconfig.util.default_config =
    vim.tbl_extend("force", lspconfig.util.default_config, {
      on_attach = on_attach,
      capabilities = create_capabilities(),
      flags = {
        debounce_text_changes = 300,
      },
    })

  mason.setup()
  mason_lspconfig.setup()
  mason_lspconfig.setup_handlers({
    function(server_name) -- default handler
      lspconfig[server_name].setup({})
    end,
    ["lua_ls"] = function()
      require("neodev").setup({
        library = {
          runtime = true,
          types = true,
          plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
        },
        lspconfig = false,
      })
      lspconfig.lua_ls.setup({
        before_init = require("neodev.lsp").before_init,
        settings = {
          Lua = {
            format = { enable = false },
            workspace = {
              ignoreDir = { "undodir/**/*.lua" },
            },
          },
        },
      })
    end,
    ["jsonls"] = function()
      lspconfig.jsonls.setup({
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
          },
        },
      })
    end,
    ["yamlls"] = function()
      lspconfig.yamlls.setup({
        settings = {
          redhat = {
            telemetry = {
              enabled = false,
            },
          },
          yaml = {
            hover = true,
            completion = true,
            validate = true,
            schemas = require("schemastore").json.schemas(),
            format = {
              enable = false,
            },
          },
        },
      })
    end,
    ["lemminx"] = function()
      lspconfig.lemminx.setup({
        init_options = {
          settings = {
            xml = {
              format = {
                splitAttributes = true,
              },
            },
          },
        },
      })
    end,
    ["volar"] = function()
      lspconfig.volar.setup({
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
        end,
      })
    end,
    ["jedi_language_server"] = function()
      lspconfig.jedi_language_server.setup({
        init_options = {
          diagnostics = { enable = false },
        },
      })
    end,
    ["rust_analyzer"] = function()
      lspconfig.rust_analyzer.setup({
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = {
              command = "clippy",
            },
          },
        },
      })
    end,
    ["tsserver"] = function()
      local typescript = require("typescript")
      typescript.setup({
        disable_commands = false, -- prevent the plugin from creating Vim commands
        debug = false, -- enable debug logging for commands
        server = { -- pass options to lspconfig's setup method
          on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            client.server_capabilities.documentFormattingProvider = false
          end,
          capabilities = create_capabilities(),
          settings = {
            typescript = {
              format = {
                tabSize = 2,
                indentSize = 2,
                convertTabsToSpaces = true,
              },
            },
          },
        },
      })
    end,
  })

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] =
    vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = "rounded",
    })

  local signs =
    { Error = " ", Warning = " ", Hint = " ", Information = " " }

  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end

  fidget.setup({})
end

return M
