return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      { "<leader>li", "<cmd>LspInfo<cr>", desc = "Lsp info" },
      { "<leader>lr", "<cmd>LspRestart<cr>", desc = "Restart LSP servers" },
    },
    dependencies = {
      "typescript.nvim",
      "mason.nvim",
      "mason-lspconfig.nvim",
      "lsp_signature.nvim",
      "fidget.nvim",
      "aerial.nvim",
      "schemastore.nvim",
      "neodev.nvim",
    },
    config = function()
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

      local function with_desc(opts, desc)
        return vim.tbl_extend("force", opts, { desc = desc })
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(args)
          local opts = { buffer = args.buf, silent = true }
          local buf_map = bind_map(opts)
          local lsp = vim.lsp.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)

          buf_map("gd", lsp.definition, "Go to definition")
          buf_map("gD", lsp.declaration, "Go to declaration")
          buf_map("K", lsp.hover, "Display hover information")
          buf_map("gi", lsp.implementation, "List implementations")
          buf_map("gr", "<cmd>TroubleToggle lsp_references<CR>", "List all references")
          buf_map("<leader>K", lsp.signature_help, "Display signature help")
          buf_map("<leader><space>t", lsp.type_definition, "Go to type definition")
          buf_map("<leader><space>f", lsp.format, "Format current buffer")
          buf_map("<leader><space>n", lsp.rename, "Rename all references")

          vim.keymap.set(
            { "n", "v" },
            "<leader><space>a",
            vim.lsp.buf.code_action,
            with_desc(opts, "Select code action")
          )

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
      map("<leader><space>l", diagnostic.setloclist, "Add diagnostics to location list")
      map("<leader><space>d", diagnostic.open_float, "Show diagnostics")

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
    end,
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "typescript.nvim" },
      { "mason.nvim" },
    },
    config = function()
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
        -- diagnostics_format = "[#{s}] #{c}: #{m}",
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
    end,
  },

  { "jose-elias-alvarez/typescript.nvim" },

  {
    "williamboman/mason.nvim",
    keys = {
      { "<leader>ol", "<cmd>Mason<cr>", desc = "Open Mason installer" },
    },
  },

  { "williamboman/mason-lspconfig.nvim" },

  { "ray-x/lsp_signature.nvim" },

  { "j-hui/fidget.nvim" },

  { "b0o/schemastore.nvim" },

  { "folke/neodev.nvim" },

  {
    "stevearc/aerial.nvim",
    dependencies = { "nvim-treesitter" },
    keys = {
      { "<leader>os", "<cmd>AerialToggle right<cr>", desc = "Toggle symbol tree" },
    },
    config = function()
      require("aerial").setup({
        backends = {
          ["_"] = { "lsp", "treesitter" },
          python = { "lsp" },
        },
        filter_kind = {
          ["_"] = false,
          python = {
            -- "Array",
            -- "Boolean",
            "Class",
            -- "Constant",
            "Constructor",
            "Enum",
            "EnumMember",
            -- "Event",
            -- "Field",
            -- "File",
            "Function",
            "Interface",
            -- "Key",
            "Method",
            "Module",
            -- "Namespace",
            -- "Null",
            -- "Number",
            -- "Object",
            -- "Operator",
            -- "Package",
            "Property",
            -- "String",
            "Struct",
            -- "TypeParameter",
            -- "Variable",
          },
        },
        ignore = {
          filetypes = {
            "startify",
          },
        },
      })
    end,
  },
}
