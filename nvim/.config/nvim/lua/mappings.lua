local whichkey = require("which-key")

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

whichkey.register({
  ["<C-p>"] = { "<Up>", "Search command history up", mode = "c", silent = false },
  ["<C-n>"] = { "<Down>", "Search command history down", mode = "c", silent = false },
  ["<leader>w"] = { "<cmd>w!<CR>", "Save buffer to current file" },

  ["<C-h>"] = { "<C-w>h", "Go to the left window" },
  ["<C-j>"] = { "<C-w>j", "Go to the below window" },
  ["<C-k>"] = { "<C-w>k", "Go to the above window" },
  ["<C-l>"] = { "<C-w>l", "Go to the right window" },

  ["<C-w>"] = {
    pc = { "<cmd>pclose<CR>", 'Close any "Preview" window currently open' },
    C = { "<cmd>tabclose<CR>", "Close current tab page" },
    O = { "<cmd>tabonly<CR>", "Close all other tab pages" },
    ["<C-f>"] = { "<C-w>vgf", "Open file under cursor in vertical split" },
  },

  ["<leader>"] = {
    b = {
      name = "buffer",
      a = { "<cmd>bufdo bd<CR>", "Close all buffers" },
      o = { "<cmd>BufOnly<CR>", "Close all buffers (except active buffer)" },
    },
    X = { "<cmd>edit#<CR>", "Re-open last closed buffer" },
    cd = {
      "<cmd>cd %:p:h<CR>:pwd<CR>",
      "Change directory to location of current file",
    },
  },

  -- keep screen centered when moving through search results
  n = { "nzzzv", "See :h n" },
  N = { "Nzzzv", "See :h N" },

  -- undo break points
  [","] = { ",<C-g>u", "See :h ,", mode = "i" },
  ["."] = { ".<C-g>u", "See :h .", mode = "i" },
  ["!"] = { "!<C-g>u", "See :h !", mode = "i" },
  ["?"] = { "?<C-g>u", "See :h ?", mode = "i" },

  J = { "<cmd>move '>+1<cr>gv=gv", "Move visual selection down", mode = "v" },
  K = { "<cmd>move '<-2<cr>gv=gv", "Move visual selection up", mode = "v" },
  -- ["<C-j>"] = { "<esc><cmd>move .+1<cr>==gi", "Move visual selection down", mode = "i" },
  -- ["<C-k>"] = { "<esc><cmd>move .-2<cr>==gi", "Move visual selection down", mode = "i" },

  jk = { "<ESC>", "Switch to normal mode", mode = "i" },

  -- ask before jumping tag stack if ambigous
  ["<C-]>"] = { "g<C-]>", "See :h CTRL-]" },

  -- remap 0 to go to first non-blank character (like ^)
  ["0"] = { "^", "See :h ^", mode = "n" }, -- should be mode "nvo", see comments below

  -- navigate with custom guides
  ["<Space><Space>"] = {
    "<cmd>call<space>search('<+.*+>')<CR>\"_c/+>/e<CR>",
    "Jump to next guide",
  },

  cn = { "*``cgn", "Start replacing word under cursor forwards" },
  cN = { "*``cgN", "Start replacing word under cursor backwards" },

  ["<C-u>"] = { "<Esc>viwUea", "Convert previous word to upper-case", mode = "i" },

  ["<leader>hl"] = {
    "(&hls && v:hlsearch ? ':nohls' : ':set hls').'\n'",
    "Toggle hlsearch",
    expr = true,
  },

  -- [";dt"] = { "<C-r>=strftime('%Y-%m-%d')<CR>", "Insert current date", mode = "i" },

  L = { ">gv", "Indent visual selection", mode = "v" },
  H = { "<gv", "Dedent visual selection", mode = "v" },

  gb = { "<cmd>BufferLinePick<cr>", "Pick buffer" },
})

-- TODO: https://github.com/folke/which-key.nvim/issues/174
--       put into section above when feature was added

-- keep screen centered when joining lines
whichkey.register({
  J = { "mzJ`z", "See :h J" },
})

-- navigate with custom guides
whichkey.register({
  ["<Space><Space>"] = {
    "<Esc><cmd>call<space>search('<+.*+>')<CR>\"_c/+>/e<CR>",
    "Jump to next guide",
    mode = "v",
  },
})

-- remap 0 to go to first non-blank character (like ^)
whichkey.register({
  ["0"] = { "^", "See :h ^", mode = "v" },
})
whichkey.register({
  ["0"] = { "^", "See :h ^", mode = "o" },
})

-- plugin mapping categories
whichkey.register({
  c = { name = "code", w = { name = "workspace" } },
  f = { name = "find" },
  g = { name = "git", c = { name = "commit" } },
  o = { name = "open" },
  q = { name = "diagnostics" },
  t = { name = "test" },
}, { prefix = "<leader>" })
