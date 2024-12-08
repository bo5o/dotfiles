return {
  { "mrcjkb/rustaceanvim", version = "^5", ft = { "rust" } },

  {
    "folke/lazydev.nvim",
    ft = "lua",
    dependencies = {
      "justinsgithub/wezterm-types",
    },
    opts = {
      library = {
        { path = "wezterm-types", mods = { "wezterm" } },
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      { "<leader>cI", "<cmd>LspInfo<cr>", desc = "Lsp info" },
      { "<leader>cS", "<cmd>LspRestart<cr>", desc = "Restart LSP servers" },
    },
    dependencies = {
      "mason.nvim",
      "aerial.nvim",
      {
        "williamboman/mason-lspconfig.nvim",
        dependencies = "mason.nvim",
        opts = {
          automatic_installation = false,
        },
      },
      { "b0o/schemastore.nvim", version = false },
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(args)
          local map = function(lhs, rhs, desc, mode)
            local opts = { desc = desc, buffer = args.buf, silent = true }
            vim.keymap.set(mode or "n", lhs, rhs, opts)
          end

          map("<leader>hi", function()
            vim.lsp.inlay_hint.enable(
              not vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }),
              { bufnr = args.buf }
            )
          end, "Toggle inlay hints")

          map("gd", "<cmd>Lspsaga goto_definition<cr>", "Go to definition")
          map("<leader>pd", "<cmd>Lspsaga peek_definition<cr>", "Peek definition")
          map("gD", vim.lsp.buf.declaration, "Go to declaration")
          map("<c-s>", vim.lsp.buf.signature_help, "Display signature help", { "i" })
          map("gI", vim.lsp.buf.implementation, "List implementations")
          map("gr", "<cmd>Trouble lsp_references toggle<cr>", "List all references")
          map("gy", "<cmd>Lspsaga goto_type_definition<cr>", "Go to t[y]pe definition")
          map(
            "<leader>py",
            "<cmd>Lspsaga peek_type_definition<cr>",
            "Peek type definition"
          )
          map("crn", "<cmd>Lspsaga rename<cr>", "Rename all references")
          map("crr", "<cmd>Lspsaga code_action<cr>", "Select code action")
          map(
            "<c-r><c-r>",
            "<cmd>Lspsaga code_action<cr>",
            "Select code action",
            { "v" }
          )
          map("<c-r>r", "<cmd>Lspsaga code_action<cr>", "Select code action", { "v" })
          map("<leader>cwa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
          map(
            "<leader>cwr",
            vim.lsp.buf.remove_workspace_folder,
            "Remove workspace folder"
          )
          map("<leader>cwl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, "List workspace folders")
        end,
      })

      local capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
      )

      local lspconfig = require("lspconfig")
      lspconfig.util.default_config =
        vim.tbl_extend("force", lspconfig.util.default_config, {
          capabilities = capabilities,
          flags = {
            debounce_text_changes = 300,
          },
        })

      require("plugins.lsp.python").setup()
      require("plugins.lsp.lua").setup()
      require("plugins.lsp.rust").setup()
      require("plugins.lsp.json").setup()
      require("plugins.lsp.ocaml").setup()
      require("plugins.lsp.yaml").setup()
      require("plugins.lsp.html").setup(capabilities)
      require("plugins.lsp.css").setup(capabilities)
      require("plugins.lsp.toml").setup()
      require("plugins.lsp.docker").setup()
      require("plugins.lsp.xml").setup()
      require("plugins.lsp.vue").setup()
      require("plugins.lsp.vim").setup()
      require("plugins.lsp.typescript").setup()
      require("plugins.lsp.eslint").setup()
      require("plugins.lsp.php").setup()
      require("plugins.lsp.markdown").setup()
      require("plugins.lsp.sh").setup()

      vim.diagnostic.config({
        virtual_text = false,
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "●",
            [vim.diagnostic.severity.WARN] = "●",
            [vim.diagnostic.severity.INFO] = "●",
            [vim.diagnostic.severity.HINT] = "⦿",
          },
        },
        float = {
          border = "rounded",
          source = true,
        },
      })
    end,
  },

  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
      require("tiny-inline-diagnostic").setup({
        signs = {
          left = " ",
          right = "",
          diag = "●",
          arrow = " ◀",
          up_arrow = " ▲",
          vertical = " │",
          vertical_end = " └",
        },
        blend = {
          factor = 0.22,
        },
        options = {
          multiple_diag_under_cursor = true,
          multilines = false,
          format = function(diagnostic)
            return diagnostic.message .. " [" .. string.lower(diagnostic.source) .. "]"
          end,
        },
      })
    end,
  },

  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup({
        symbols_in_winbar = {
          enable = true,
        },
        lightbulb = {
          enable = true,
          sign = false,
          virtual_text = true,
        },
        implement = {
          enable = true,
        },
        ui = {
          code_action = "🗲",
          title = false,
        },
      })
    end,
  },

  {
    "mfussenegger/nvim-lint",
    config = function()
      require("lint").linters_by_ft = {
        sql = { "sqlfluff" },
        ["sql.jinja"] = { "sqlfluff" },
        ["html.jinja"] = { "djlint" },
        ["jinja"] = { "djlint" },
        gitcommit = { "gitlint" },
        yaml = { "yamllint" },
        markdown = { "markdownlint" },
        vimwiki = { "markdownlint" },
        dockerfile = { "hadolint" },
        html = { "htmlhint" },
        css = { "stylelint" },
      }

      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
        group = vim.api.nvim_create_augroup("lint", { clear = true }),
        callback = function()
          local lint = require("lint")
          lint.try_lint()
        end,
      })
    end,
  },

  {
    "stevearc/conform.nvim",
    enabled = true,
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          sql = { "sqlfluff", "sqlfmt", "sql_formatter", stop_after_first = true },
          ["sql.jinja"] = { "sqlfluff", "sqlfmt", stop_after_first = true },
          ["html.jinja"] = { "djlint" },
          htmldjango = { "djlint" },
          python = function(bufnr)
            if
              require("conform").get_formatter_info("ruff_format", bufnr).available
            then
              return { "ruff_organize_imports", "ruff_format" }
            else
              return { "isort", "black" }
            end
          end,
          html = { "prettierd", "djlint", stop_after_first = true },
          jinja = { "djlint" },
          markdown = { "mdformat", "injected" },
          sh = { "shfmt" },
          bash = { "shfmt" },
          just = { "just" },
          css = { "prettierd" },
          yaml = { "yamlfmt" },
          toml = { "taplo" },
          ocaml = { "ocamlformat" },
          ["_"] = { "trim_whitespace" },
        },
        format_on_save = function(bufnr)
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end

          local bufname = vim.api.nvim_buf_get_name(bufnr)
          if bufname:match("/node_modules/") then
            return
          end

          return { timeout_ms = 500, lsp_format = "fallback" }
        end,
        format_after_save = function(bufnr)
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end

          local slow_format_filetypes = {}
          if not slow_format_filetypes[vim.bo[bufnr].filetype] then
            return
          end

          return { lsp_format = "fallback" }
        end,
      })
    end,
    init = function()
      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, {
        desc = "Disable autoformat-on-save",
        bang = true,
      })

      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = "Re-enable autoformat-on-save",
      })

      vim.api.nvim_create_user_command("Format", function(args)
        local range = nil
        if args.count ~= -1 then
          local end_line =
            vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
          range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
          }
        end
        require("conform").format({ async = true, lsp_fallback = true, range = range })
      end, {
        desc = "Format buffer",
        range = true,
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
