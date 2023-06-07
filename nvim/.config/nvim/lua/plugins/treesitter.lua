return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "comment",
          "typescript",
          "javascript",
          "python",
          "go",
          "jsdoc",
          "markdown",
          "html",
          "css",
          "json",
          "lua",
          "bash",
          "rst",
          "toml",
          "vue",
          "sql",
          "rust",
          "query", -- for treesitter playground
        },
        highlight = {
          enable = true,
          disable = {
            "python",
          },
        },
        indent = {
          enable = true,
          disable = {
            "python",
          },
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
        },
        textsubjects = {
          enable = true,
          keymaps = {
            ["."] = "textsubjects-smart",
            [";"] = "textsubjects-container-outer",
            ["i;"] = "textsubjects-container-inner",
          },
        },
        rainbow = {
          enable = true,
          extended_mode = false,
          max_file_lines = 1000,
        },
        playground = {
          enable = true,
          disable = {},
          updatetime = 25,
          persist_queries = false,
        },
        query_linter = {
          enable = true,
          use_virtual_text = true,
          lint_events = { "BufWrite", "CursorHold" },
        },
        autotag = {
          enable = true,
        },
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
        matchup = {
          enable = true,
        },
      })
    end,
  },
  -- Advanced text objects
  { "nvim-treesitter/nvim-treesitter-textobjects", dependencies = "nvim-treesitter" },
  -- Context-aware text objects
  { "RRethy/nvim-treesitter-textsubjects", dependencies = "nvim-treesitter" },
  -- Always show treesitter context
  { "nvim-treesitter/nvim-treesitter-context", dependencies = "nvim-treesitter" },
  -- Colorize nested parentheses
  { "mrjones2014/nvim-ts-rainbow", dependencies = "nvim-treesitter" },
  -- Auto-close and -rename html tags
  { "windwp/nvim-ts-autotag", dependencies = "nvim-treesitter" },
  -- Auto-set 'commentstring'
  { "JoosepAlviste/nvim-ts-context-commentstring", dependencies = "nvim-treesitter" },
  -- Explore treesitter
  {
    "nvim-treesitter/playground",
    dependencies = "nvim-treesitter",
    keys = {
      {
        "<leader>ot",
        "<cmd>TSPlaygroundToggle<cr>",
        desc = "Toggle treesitter playground",
      },
    },
  },
}
