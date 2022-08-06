local M = {}

function M.config()
  local mason = require("mason")
  local mason_lspconfig = require("mason-lspconfig")
  local lspconfig = require("lspconfig")
  local cmp_lsp = require("cmp_nvim_lsp")
  local lsp_signature = require("lsp_signature")
  local fidget = require("fidget")
  local aerial = require("aerial")
  local lsp_lines = require("lsp_lines")

  local function create_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = cmp_lsp.update_capabilities(capabilities)
    return cmp_lsp.update_capabilities(capabilities)
  end

  local function bind_map(default_opts)
    return function(lhs, rhs, desc)
      local opts = vim.tbl_extend("force", default_opts, { desc = desc })
      vim.keymap.set("n", lhs, rhs, opts)
    end
  end

  local map = bind_map({ silent = true })
  local diagnostic = vim.diagnostic
  map("[g", diagnostic.goto_prev, "Go to previous diagnostic")
  map("]g", diagnostic.goto_next, "Go to next diagnostic")
  map("<leader>lq", diagnostic.setloclist, "Add diagnostics to location list")
  map("<leader>lg", diagnostic.open_float, "Show diagnostics")

  ---@diagnostic disable-next-line: unused-local
  local on_attach = function(client, bufnr)
    local buf_map = bind_map({ silent = true, buffer = bufnr })
    local lsp = vim.lsp.buf

    buf_map("gd", lsp.definition, "Go to definition")
    buf_map("gD", lsp.declaration, "Go to declaration")
    buf_map("K", lsp.hover, "Display hover information")
    buf_map("gi", lsp.implementation, "List implementations")
    buf_map("gr", "<cmd>TroubleToggle lsp_references<CR>", "List all references")
    buf_map("<leader>K", lsp.signature_help, "Display signature help")
    buf_map("<leader>ld", lsp.type_definition, "Go to type definition")
    buf_map("<leader>lf", lsp.formatting, "Format current buffer")
    buf_map("<leader>ln", lsp.rename, "Rename all references")
    buf_map("<leader>lc", lsp.code_action, "Select code action")
    buf_map("<leader>lwa", lsp.add_workspace_folder, "Add workspace folder")
    buf_map("<leader>lwr", lsp.remove_workspace_folder, "Remove workspace folder")
    buf_map("<leader>lwl", function()
      print(vim.inspect(lsp.list_workspace_folders()))
    end, "List workspace folders")

    -- Configure signature help for completion
    lsp_signature.on_attach({
      bind = true,
      hint_enable = false,
      hi_parameter = "Search",
    })

    -- for lsp symbol tree
    aerial.on_attach(client, bufnr)

    -- for lsp lines
    vim.diagnostic.config({ virtual_text = false, virtual_lines = false })
    buf_map("<leader>ll", lsp_lines.toggle, "Show/hide lsp diagnostics")
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
    ["sumneko_lua"] = function()
      local luadev = require("lua-dev").setup({
        library = {
          vimruntime = true,
          types = true,
          plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
        },
        lspconfig = {
          settings = {
            Lua = {
              format = { enable = false },
            },
          },
        },
      })
      lspconfig.sumneko_lua.setup(luadev)
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
          client.resolved_capabilities.document_formatting = false
          client.resolved_capabilities.document_range_formatting = false
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
    ["tsserver"] = function()
      local typescript = require("typescript")
      typescript.setup({
        disable_commands = false, -- prevent the plugin from creating Vim commands
        debug = false, -- enable debug logging for commands
        server = { -- pass options to lspconfig's setup method
          on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            client.resolved_capabilities.document_formatting = false
            client.resolved_capabilities.document_range_formatting = false

            local buf_map = bind_map({ silent = true, buffer = bufnr })
            buf_map(
              "<leader>lm",
              "<cmd>TypescriptRenameFile<cr>",
              "Rename file and update imports"
            )
            buf_map("<leader>lI", function()
              typescript.actions.addMissingImports({ sync = true })
            end, "Import missing imports")
            buf_map("<leader>lo", function()
              typescript.actions.organizeImports({ sync = true })
            end, "Organize imports")
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

  local signs =
    { Error = " ", Warning = " ", Hint = " ", Information = " " }

  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end

  fidget.setup({})
end

return M
