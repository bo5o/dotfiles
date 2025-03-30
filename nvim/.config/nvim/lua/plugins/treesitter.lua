return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      {
        "<leader>oT",
        "<cmd>InspectTree<cr>",
        desc = "Inspect treesitter tree",
      },
    },
    opts = {
      ensure_installed = {
        "bash",
        "comment",
        "css",
        "diff",
        "dockerfile",
        "gitcommit",
        "git_rebase",
        "go",
        "gomod",
        "gowork",
        "gosum",
        "graphql",
        "html",
        "htmldjango",
        "http",
        "javascript",
        "jsdoc",
        "json",
        "json5",
        "jsonc",
        "just",
        "java",
        "lua",
        "markdown",
        "markdown_inline",
        "php",
        "python",
        "query", -- for treesitter playground
        "regex",
        "rst",
        "rust",
        "sql",
        "toml",
        "yaml",
        "typescript",
        "typst",
        "vim",
        "vue",
        "xml",
      },
      highlight = {
        enable = true,
        disable = { "just" },
      },
      indent = {
        enable = true,
      },
      autopairs = {
        enable = true,
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["as"] = {
              query = "@scope",
              query_group = "locals",
              desc = "Select language scope",
            },
          },
          include_surrounding_whitespace = false,
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
        },
        swap = {
          enable = true,
        },
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<Enter>",
          node_incremental = "<Enter>",
          node_decremental = "<BS>",
        },
      },
      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      },
      autotag = {
        enable = true,
      },
      matchup = {
        enable = true,
      },
    },
    main = "nvim-treesitter.configs",
    init = function()
      require("vim.treesitter.query").add_predicate("is-mise?", function(_, _, bufnr, _)
        local filepath = vim.api.nvim_buf_get_name(tonumber(bufnr) or 0)
        local filename = vim.fn.fnamemodify(filepath, ":t")
        return string.match(filename, ".*mise.*%.toml$") ~= nil
      end, { force = true, all = false })
    end,
  },
  -- Advanced text objects
  { "nvim-treesitter/nvim-treesitter-textobjects", dependencies = "nvim-treesitter" },
  -- Always show treesitter context
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = "nvim-treesitter",
    opts = { separator = "-", max_lines = 3 },
  },
  -- Navigate around treesitter nodes
  {
    "aaronik/treewalker.nvim",
    config = function()
      require("treewalker").setup({ highlight = false })

      local hydra = require("hydra")

      -- movement
      hydra({
        name = "Walk",
        mode = "n",
        body = "gw",
        heads = {
          { "h", "<cmd>Treewalker Left<cr>", { desc = "Go to node to the left" } },
          { "j", "<cmd>Treewalker Down<cr>", { desc = "Go to node below" } },
          { "k", "<cmd>Treewalker Up<cr>", { desc = "Go to node above" } },
          { "l", "<cmd>Treewalker Right<cr>", { desc = "Go to node to the right" } },
        },
      })

      -- swapping
      hydra({
        name = "Swap",
        mode = "n",
        body = "gs",
        heads = {
          {
            "h",
            "<cmd>Treewalker SwapLeft<cr>",
            { desc = "Swap with node to the left" },
          },
          {
            "j",
            "<cmd>Treewalker SwapDown<cr>",
            { desc = "Swap with node below" },
          },
          {
            "k",
            "<cmd>Treewalker SwapUp<cr>",
            { desc = "Swap with node above" },
          },
          {
            "l",
            "<cmd>Treewalker SwapRight<cr>",
            { desc = "Swap with node to the right" },
          },
        },
      })
    end,
  },
  -- Colorize nested parentheses
  {
    "HiPhish/rainbow-delimiters.nvim",
    -- rainbow delimiters cause noticeable lag
    -- maybe some day will re-enable it
    enabled = false,
    dependencies = "nvim-treesitter",
    config = function()
      require("rainbow-delimiters").setup({
        query = {
          [""] = "rainbow-delimiters",
          html = "rainbow-tags",
          vue = "rainbow-tags",
          latex = "rainbow-blocks",
        },
      })
    end,
  },

  -- Auto-close and -rename html tags
  { "windwp/nvim-ts-autotag", dependencies = "nvim-treesitter" },

  -- Node actions
  {
    "ckolkey/ts-node-action",
    dev = false,
    dependencies = "nvim-treesitter",
    config = function()
      require("ts-node-action").setup({})

      vim.keymap.set(
        "n",
        "-",
        require("ts-node-action").node_action,
        { desc = "Trigger node action" }
      )
    end,
  },

  -- Comments
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
  },
}
