vim.g.nvim_tree_auto_ignore_ft = { "startify", "dashboard" }

local tree_cb = require("nvim-tree.config").nvim_tree_callback

require("nvim-tree").setup({
  view = {
    mappings = {
      list = {
        { key = { "<CR>", "o", "<2-LeftMouse>", "l" }, cb = tree_cb("edit") },
        { key = { "<BS>", "h" }, cb = tree_cb("close_node") },
        { key = "zh", cb = tree_cb("toggle_dotfiles") },
        { key = "zi", cb = tree_cb("toggle_ignored") },
        { key = { "-", "H" }, cb = tree_cb("dir_up") },
        { key = { "<2-RightMouse>", "<C-]>", "L" }, cb = tree_cb("cd") },
      },
    },
  },
  filters = {
    dotfiles = true,
    custom = { ".git", "node_modules", ".cache", "__pycache__" },
  },
  renderer = {
    highlight_git = true,
    add_trailing = true,
    indent_markers = {
      enable = true,
    },
  },
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
})
