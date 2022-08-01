local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")
local cmp_lsp = require("cmp_nvim_lsp")
local lsp_signature = require("lsp_signature")
local fidget = require("fidget")

local function create_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = cmp_lsp.update_capabilities(capabilities)
  return cmp_lsp.update_capabilities(capabilities)
end

local function make_keymap_func(default_opts)
  return function(mode, lhs, rhs, opts)
    local opts = vim.tbl_extend("force", default_opts, opts)
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

local set_keymap = make_keymap_func({ noremap = true, silent = true })
set_keymap("n", "[g", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
set_keymap("n", "]g", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
set_keymap(
  "n",
  "<leader>lq",
  vim.diagnostic.setloclist,
  { desc = "Add diagnostics to location list" }
)
set_keymap("n", "<leader>lg", vim.diagnostic.open_float, { desc = "Show diagnostics" })

local on_attach = function(client, bufnr)
  local buf_set_keymap =
    make_keymap_func({ noremap = true, silent = true, buffer = bufnr })

  buf_set_keymap("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
  buf_set_keymap("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
  buf_set_keymap("n", "K", vim.lsp.buf.hover, { desc = "Display hover information" })
  buf_set_keymap(
    "n",
    "gi",
    vim.lsp.buf.implementation,
    { desc = "List implementations" }
  )
  buf_set_keymap(
    "n",
    "gr",
    "<cmd>TroubleToggle lsp_references<CR>",
    { desc = "List all references" }
  )
  buf_set_keymap(
    "n",
    "<leader>K",
    vim.lsp.buf.signature_help,
    { desc = "Display signature help" }
  )
  buf_set_keymap(
    "n",
    "<leader>ld",
    vim.lsp.buf.type_definition,
    { desc = "Go to type definition" }
  )
  buf_set_keymap(
    "n",
    "<leader>lf",
    vim.lsp.buf.formatting,
    { desc = "Format current buffer" }
  )
  buf_set_keymap(
    "n",
    "<leader>ln",
    vim.lsp.buf.rename,
    { desc = "Rename all references" }
  )
  buf_set_keymap(
    "n",
    "<leader>lc",
    vim.lsp.buf.code_action,
    { desc = "Select code action" }
  )
  buf_set_keymap(
    "n",
    "<leader>lwa",
    vim.lsp.buf.add_workspace_folder,
    { desc = "Add workspace folder" }
  )
  buf_set_keymap(
    "n",
    "<leader>lwr",
    vim.lsp.buf.remove_workspace_folder,
    { desc = "Remove workspace folder" }
  )
  buf_set_keymap("n", "<leader>lwl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, { desc = "List workspace folders" })

  -- Configure signature help for completion
  lsp_signature.on_attach({
    bind = true,
    hint_enable = false,
    hi_parameter = "Search",
  })
end

lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
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
        yaml = {
          hover = true,
          completion = true,
          validate = true,
          schemas = require("schemastore").json.schemas(),
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
          client.resolved_capabilities.document_formatting = false
          client.resolved_capabilities.document_range_formatting = false

          local buf_set_keymap = make_keymap_func({
            noremap = true,
            silent = true,
            buffer = bufnr,
          })
          buf_set_keymap(
            "n",
            "<leader>lm",
            "<cmd>TypescriptRenameFile<cr>",
            { desc = "Rename file and update imports" }
          )
          buf_set_keymap(
            "n",
            "<leader>lI",
            typescript.actions.addMissingImports,
            { desc = "Import all missing imports" }
          )
          buf_set_keymap(
            "n",
            "<leader>lo",
            typescript.actions.organizeImports,
            { desc = "Organize imports" }
          )
        end,
      },
    })
  end,
})

local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

fidget.setup({})
