return {
  { "jose-elias-alvarez/typescript.nvim", lazy = true },
  { "mrcjkb/rustaceanvim", version = "^3", ft = { "rust" } },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      { "<leader>cI", "<cmd>LspInfo<cr>", desc = "Lsp info" },
      { "<leader>cS", "<cmd>LspRestart<cr>", desc = "Restart LSP servers" },
    },
    dependencies = {
      "typescript.nvim",
      "mason.nvim",
      "aerial.nvim",
      {
        "williamboman/mason-lspconfig.nvim",
        dependencies = "mason.nvim",
        opts = {
          automatic_installation = false,
        },
      },
      { "ray-x/lsp_signature.nvim" },
      {
        "j-hui/fidget.nvim",
        opts = {
          notification = {
            window = {
              winblend = 10,
              border = "single",
            },
          },
        },
      },
      { "b0o/schemastore.nvim", version = false },
      { "folke/neodev.nvim" },
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(args)
          local lsp = vim.lsp.buf
          local map = function(lhs, rhs, desc, mode)
            local opts = { desc = desc, buffer = args.buf, silent = true }
            vim.keymap.set(mode or "n", lhs, rhs, opts)
          end

          map("gd", lsp.definition, "Go to definition")
          map("gD", lsp.declaration, "Go to declaration")
          map("K", lsp.hover, "Display hover information")
          map("<leader>k", lsp.signature_help, "Display signature help")
          map("gI", lsp.implementation, "List implementations")
          map("gr", "<cmd>TroubleToggle lsp_references<CR>", "List all references")
          map("gy", lsp.type_definition, "Go to t[y]pe definition")
          map("<leader>cf", lsp.format, "Format current buffer")
          map("<leader>cr", lsp.rename, "Rename all references")
          map("<leader>ca", lsp.code_action, "Select code action", { "n", "v" })
          map("<leader>cwa", lsp.add_workspace_folder, "Add workspace folder")
          map("<leader>cwr", lsp.remove_workspace_folder, "Remove workspace folder")
          map("<leader>cwl", function()
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
      require("plugins.lsp.rust").setup(on_attach)
      require("plugins.lsp.json").setup()
      require("plugins.lsp.yaml").setup()
      require("plugins.lsp.toml").setup()
      require("plugins.lsp.docker").setup()
      require("plugins.lsp.xml").setup()
      require("plugins.lsp.vue").setup(on_attach)
      require("plugins.lsp.typescript").setup(on_attach, capabilities)
      require("plugins.lsp.php").setup()
      require("plugins.lsp.markdown").setup()
      require("plugins.lsp.sh").setup()

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
    "nvimtools/none-ls.nvim",
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
          -- Lua
          builtins.formatting.stylua,
          -- Gitcommit
          builtins.diagnostics.gitlint,
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
            extra_filetypes = { "sql.jinja" },
            condition = function(utils)
              return utils.root_has_file({ ".sqlfluff" })
            end,
            to_stdin = false,
            timeout = 10000,
            args = {
              "lint",
              "-f",
              "github-annotation",
              "-n",
              "--disable-progress-bar",
              "$FILENAME",
            },
            prefer_local = true,
          }),
          builtins.formatting.sqlfmt.with({
            filetypes = { "sql.jinja" },
            condition = function(utils)
              return utils.root_has_file({ "dbt_project.yml" })
            end,
            prefer_local = true,
          }),
          builtins.formatting.sql_formatter.with({
            filetypes = { "sql" },
            extra_args = function(params)
              local config = search_upwards(".sql-formatter.json", {
                start_from = params.bufname,
                stop_at = params.root,
              })
              return config and { "--config", config } or {}
            end,
            prefer_local = "node_modules/.bin",
          }),
          -- Markdown
          builtins.formatting.mdformat.with({
            filetypes = { "markdown" },
            condition = function(utils)
              return utils.root_has_file({ ".mdformat.toml" })
            end,
          }),
          builtins.formatting.prettierd.with({
            filetypes = { "markdown" },
            condition = function(utils)
              return not utils.root_has_file({ ".mdformat.toml" })
            end,
          }),
          -- CSS/HTML/YAML
          builtins.diagnostics.yamllint,
          builtins.diagnostics.markdownlint.with({
            filetypes = { "markdown", "vimwiki" },
          }),
          builtins.formatting.prettierd.with({
            filetypes = { "css", "html", "yaml" },
          }),
          -- Dockerfile
          builtins.diagnostics.hadolint,
          -- Shell
          builtins.diagnostics.shellcheck.with({
            filetypes = { "zsh" }, -- https://github.com/bash-lsp/bash-language-server/issues/252
          }),
          builtins.formatting.shfmt,
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
    opts = {
      ui = {
        height = 0.7,
        border = "rounded",
      },
    },
  },

  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "none-ls.nvim",
    },
    opts = {
      ensure_installed = nil,
      automatic_installation = false,
    },
  },

  {
    "stevearc/aerial.nvim",
    dependencies = { "nvim-treesitter" },
    keys = {
      { "<leader>os", "<cmd>AerialToggle right<cr>", desc = "Toggle symbol tree" },
    },
    opts = {
      backends = { "lsp", "treesitter", "markdown", "man" },
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
    },
  },
}
