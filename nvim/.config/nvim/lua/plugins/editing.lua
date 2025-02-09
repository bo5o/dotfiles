return {
  {
    "echasnovski/mini.align",
    version = "*",
    keys = {
      { "ga", mode = { "n", "v" } },
      { "gA", mode = { "n", "v" } },
    },
    opts = {},
  },

  {
    "monaqa/dial.nvim",
    lazy = true,
    keys = {
      {
        "<C-b>",
        function()
          require("dial.map").manipulate("increment", "normal")
        end,
      },
      {
        "<C-x>",
        function()
          require("dial.map").manipulate("decrement", "normal")
        end,
      },
      {
        "g<C-b>",
        function()
          require("dial.map").manipulate("increment", "gnormal")
        end,
      },
      {
        "g<C-x>",
        function()
          require("dial.map").manipulate("decrement", "gnormal")
        end,
      },
      {
        "<C-b>",
        function()
          require("dial.map").manipulate("increment", "visual")
        end,
        mode = "v",
      },
      {
        "<C-x>",
        function()
          require("dial.map").manipulate("decrement", "visual")
        end,
        mode = "v",
      },
      {
        "g<C-b>",
        function()
          require("dial.map").manipulate("increment", "gvisual")
        end,
        mode = "v",
      },
      {
        "g<C-x>",
        function()
          require("dial.map").manipulate("decrement", "gvisual")
        end,
        mode = "v",
      },
    },
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          augend.date.alias["%Y-%m-%d"],
          augend.date.alias["%m/%d"],
          augend.date.alias["%H:%M"],
          augend.date.alias["%d.%m.%Y"],
          augend.date.alias["%d.%m.%y"],
          augend.date.alias["%H:%M:%S"],
          augend.semver.alias.semver,
        },
      })
    end,
  },

  {
    "Wansmer/treesj",
    keys = {
      { "gS", "<cmd>TSJToggle<cr>", desc = "Toggle single/multi-line statement" },
    },
    opts = {
      use_default_keymaps = false,
    },
  },

  { "tpope/vim-surround", event = "BufRead" },

  {
    "mattn/emmet-vim",
    ft = { "html", "htmldjango", "vue", "css" },
    init = function()
      vim.g.user_emmet_install_global = 0
    end,
    config = function()
      vim.api.nvim_command("EmmetInstall")
    end,
  },
}
