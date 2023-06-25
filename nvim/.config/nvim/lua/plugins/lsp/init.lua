return {
  { "jose-elias-alvarez/typescript.nvim", lazy = true },

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
      "aerial.nvim",
      {
        "williamboman/mason-lspconfig.nvim",
        dependencies = "mason.nvim",
        config = function()
          require("mason-lspconfig").setup({
            automatic_installation = true,
          })
        end,
      },
      { "ray-x/lsp_signature.nvim" },
      { "j-hui/fidget.nvim", tag = "legacy" },
      { "b0o/schemastore.nvim" },
      { "folke/neodev.nvim" },
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(args)
          local lsp = vim.lsp.buf
          local map = function(mode, lhs, rhs, desc)
            local opts = { desc = desc, buffer = args.buf, silent = true }
            vim.keymap.set(mode, lhs, rhs, opts)
          end

          map("n", "gd", lsp.definition, "Go to definition")
          map("n", "gD", lsp.declaration, "Go to declaration")
          map("n", "K", lsp.hover, "Display hover information")
          map("n", "gi", lsp.implementation, "List implementations")
          map("n", "gr", "<cmd>TroubleToggle lsp_references<CR>", "List all references")
          map("n", "<leader>K", lsp.signature_help, "Display signature help")
          map("n", "<leader><space>t", lsp.type_definition, "Go to type definition")
          map("n", "<leader><space>f", lsp.format, "Format current buffer")
          map("n", "<leader><space>n", lsp.rename, "Rename all references")
          map("n", "<leader><space>n", lsp.rename, "Rename all references")
          map({ "n", "v" }, "<leader><space>a", lsp.code_action, "Select code action")
          map("n", "<leader>lwa", lsp.add_workspace_folder, "Add workspace folder")
          map(
            "n",
            "<leader>lwr",
            lsp.remove_workspace_folder,
            "Remove workspace folder"
          )
          map("n", "<leader>lwl", function()
            print(vim.inspect(lsp.list_workspace_folders()))
          end, "List workspace folders")
        end,
      })

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

      local map = function(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { desc = desc, silent = true })
      end
      map("[d", diagnostic.goto_prev, "Go to previous diagnostic")
      map("]d", diagnostic.goto_next, "Go to next diagnostic")
      map("<leader><space>l", diagnostic.setloclist, "Add diagnostics to location list")
      map("<leader><space>d", diagnostic.open_float, "Show diagnostics")

      ---@diagnostic disable-next-line: unused-local
      local on_attach = function(client, bufnr)
        -- Configure signature help for completion
        require("lsp_signature").on_attach({
          bind = true,
          hint_enable = false,
          hi_parameter = "Search",
        })
      end

      local capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
      )

      local lspconfig = require("lspconfig")
      lspconfig.util.default_config =
        vim.tbl_extend("force", lspconfig.util.default_config, {
          on_attach = on_attach,
          capabilities = capabilities,
          flags = {
            debounce_text_changes = 300,
          },
        })

      require("plugins.lsp.python").setup()
      require("plugins.lsp.lua").setup()
      require("plugins.lsp.rust").setup()
      require("plugins.lsp.json").setup()
      require("plugins.lsp.yaml").setup()
      require("plugins.lsp.toml").setup()
      require("plugins.lsp.docker").setup()
      require("plugins.lsp.xml").setup()
      require("plugins.lsp.vue").setup(on_attach)
      require("plugins.lsp.typescript").setup(on_attach, capabilities)
      require("plugins.lsp.php").setup()

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
      })

      vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers.signature_help, {
          border = "rounded",
        })

      for type, icon in pairs({
        Error = " ",
        Warning = " ",
        Hint = " ",
        Information = " ",
      }) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      require("fidget").setup({})
    end,
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "typescript.nvim" },
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
      local methods = null_ls.methods
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
            method = methods.DIAGNOSTICS_ON_SAVE,
            condition = function(utils)
              return utils.root_has_file(".pylintrc")
            end,
            dynamic_command = function(params)
              return from_virtual_env(params)
                or vim.fn.executable(params.command) == 1 and params.command
            end,
          }),
          builtins.diagnostics.flake8.with({
            method = methods.DIAGNOSTICS_ON_SAVE,
            dynamic_command = function(params)
              return from_virtual_env(params)
                or vim.fn.executable(params.command) == 1 and params.command
            end,
          }),
          builtins.diagnostics.mypy.with({
            method = methods.DIAGNOSTICS_ON_SAVE,
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
            method = methods.DIAGNOSTICS_ON_SAVE,
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

  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    cmd = "Mason",
    keys = {
      { "<leader>ol", "<cmd>Mason<cr>", desc = "Open Mason installer" },
    },
    config = function()
      require("mason").setup({
        ui = {
          height = 0.7,
          border = "rounded",
        },
      })
    end,
  },

  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "null-ls.nvim",
    },
    config = function()
      require("mason-null-ls").setup({
        ensure_installed = nil,
        automatic_installation = {
          exclude = {
            "trim_whitespace",
            "trim_newlines",
          },
        },
      })
    end,
  },

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
