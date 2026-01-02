return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    keys = {
      {
        "<leader>oT",
        "<cmd>InspectTree<cr>",
        desc = "Inspect treesitter tree",
      },
    },
    init = function()
      require("vim.treesitter.query").add_predicate("is-mise?", function(_, _, bufnr, _)
        local filepath = vim.api.nvim_buf_get_name(tonumber(bufnr) or 0)
        local filename = vim.fn.fnamemodify(filepath, ":t")
        return string.match(filename, ".*mise.*%.toml$") ~= nil
      end, { force = true, all = false })
    end,
  },

  {
    "MeanderingProgrammer/treesitter-modules.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    lazy = false,
    ---@module 'treesitter-modules'
    ---@type ts.mod.UserConfig
    keys = {
      {
        "<Enter>",
        function()
          require("treesitter-modules").init_selection()
        end,
        mode = "n",
        desc = "Init incremental selection",
      },
      {
        "<Enter>",
        function()
          require("treesitter-modules").node_incremental()
        end,
        mode = "x",
        desc = "Expand incremental selection",
      },
      {
        "<BS>",
        function()
          require("treesitter-modules").node_decremental()
        end,
        mode = "x",
        desc = "Shrink incremental selection",
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
        "groovy",
        "html",
        "htmldjango",
        "http",
        "javascript",
        "jsdoc",
        "json",
        "json5",
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
      incremental_selection = {
        enable = true,
      },
    },
  },
  -- Advanced text objects
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    lazy = false,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = {
      {
        "af",
        function()
          local select = require("nvim-treesitter-textobjects.select")
          select.select_textobject("@function.outer", "textobjects")
        end,
        mode = { "x", "o" },
        desc = "Select outer function",
      },
      {
        "if",
        function()
          local select = require("nvim-treesitter-textobjects.select")
          select.select_textobject("@function.inner", "textobjects")
        end,
        mode = { "x", "o" },
        desc = "Select inner function",
      },
      {
        "ac",
        function()
          local select = require("nvim-treesitter-textobjects.select")
          select.select_textobject("@class.outer", "textobjects")
        end,
        mode = { "x", "o" },
        desc = "Select outer class",
      },
      {
        "ic",
        function()
          local select = require("nvim-treesitter-textobjects.select")
          select.select_textobject("@class.inner", "textobjects")
        end,
        mode = { "x", "o" },
        desc = "Select inner class",
      },
      {
        "as",
        function()
          local select = require("nvim-treesitter-textobjects.select")
          select.select_textobject("@local.scope", "locals")
        end,
        mode = { "x", "o" },
        desc = "Select local scope",
      },
      {
        "]m",
        function()
          local move = require("nvim-treesitter-textobjects.move")
          move.goto_next_start("@function.outer", "textobjects")
        end,
        mode = { "n", "x", "o" },
        desc = "Next function start",
      },
      {
        "]]",
        function()
          local move = require("nvim-treesitter-textobjects.move")
          move.goto_next_start("@class.outer", "textobjects")
        end,
        mode = { "n", "x", "o" },
        desc = "Next class start",
      },
      {
        "[m",
        function()
          local move = require("nvim-treesitter-textobjects.move")
          move.goto_previous_start("@function.outer", "textobjects")
        end,
        mode = { "n", "x", "o" },
        desc = "Previous function start",
      },
      {
        "[[",
        function()
          local move = require("nvim-treesitter-textobjects.move")
          move.goto_previous_start("@class.outer", "textobjects")
        end,
        mode = { "n", "x", "o" },
        desc = "Previous class start",
      },
    },
    opts = {
      select = {
        lookahead = true,
        include_surrounding_whitespace = false,
      },
      move = {
        set_jumps = true,
      },
    },
  },

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
        body = "gW",
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

  -- Auto-close and -rename html tags
  {
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
  },

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
