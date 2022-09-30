local M = {}

function M.config()
  require("nvim-treesitter.configs").setup({
    ensure_installed = {
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
        },
      },
      move = {
        enable = true,
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
      max_file_lines = 800,
    },
    playground = {
      enable = true,
      disable = {},
      updatetime = 25,
      persist_queries = false,
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
end

return M
