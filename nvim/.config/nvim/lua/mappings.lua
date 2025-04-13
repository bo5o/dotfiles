local whichkey = require("which-key")

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set("c", "<C-p>", "<Up>", {
  desc = "Search command history up",
  silent = false,
})
vim.keymap.set("c", "<C-n>", "<Down>", {
  desc = "Search command history down",
  silent = false,
})

vim.keymap.set("n", "<leader>w", "<cmd>w!<CR>", {
  desc = "Save buffer to current file",
})

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to the left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to the below window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to the above window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to the right window" })

vim.keymap.set("n", "<C-w>_", "<C-w>-", { desc = "Decrease height" })
vim.keymap.set("n", "<C-w>-", "<C-w>s", { desc = "Split window" })
vim.keymap.set("n", "<C-w>|", "<C-w>v", { desc = "Split window vertically" })

vim.keymap.set("n", "<C-w>pc", "<cmd>pclose<CR>", {
  desc = 'Close any "Preview" window currently open',
})
vim.keymap.set("n", "<C-w>C", "<cmd>tabclose<CR>", { desc = "Close current tab page" })
vim.keymap.set("n", "<C-w>Q", "<cmd>tabclose<CR>", { desc = "Close current tab page" })
vim.keymap.set("n", "<C-w>O", "<cmd>tabonly<CR>", {
  desc = "Close all other tab pages",
})
vim.keymap.set("n", "<C-w><C-f>", "<C-w>vgf", {
  desc = "Open file under cursor in vertical split",
})

vim.keymap.set("n", "<leader>ba", "<cmd>bufdo bd<CR>", { desc = "Close all buffers" })
vim.keymap.set("n", "<leader>bo", "<cmd>BufOnly<CR>", {
  desc = "Close all buffers (except active buffer)",
})

vim.keymap.set("n", "<leader>X", "<cmd>edit#<CR>", {
  desc = "Re-open last closed buffer",
})
vim.keymap.set("n", "<leader>cd", "<cmd>cd %:p:h<CR>:pwd<CR>", {
  desc = "Change directory to location of current file",
})

-- keep screen centered when moving through search results
vim.keymap.set("n", "n", "nzzzv", { desc = "See :h n" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "See :h N" })

-- undo break points
vim.keymap.set("i", ",", ",<C-g>u", { desc = "See :h ," })
vim.keymap.set("i", ".", ".<C-g>u", { desc = "See :h ." })
vim.keymap.set("i", "!", "!<C-g>u", { desc = "See :h !" })
vim.keymap.set("i", "?", "?<C-g>u", { desc = "See :h ?" })

vim.keymap.set("v", "J", "<cmd>move '>+1<cr>gv=gv", {
  desc = "Move visual selection down",
})
vim.keymap.set("v", "K", "<cmd>move '<-2<cr>gv=gv", {
  desc = "Move visual selection up",
})

vim.keymap.set("i", "jk", "<ESC>", { desc = "Switch to normal mode" })

-- jump around diagnostics
vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({ count = 1, wrap = false })
end, { desc = "Jump to the next diagnostic" })
vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump({ count = -1, wrap = false })
end, { desc = "Jump to the previous diagnostic" })

-- ask before jumping tag stack if ambigous
vim.keymap.set("n", "C-]", "g<C-]>", { desc = "See :h CTRL-]" })

-- remap 0 to go to first non-blank character (like ^)
vim.keymap.set({ "n", "v", "o" }, "0", "^", { desc = "See :h ^" })

-- navigate with custom guides
vim.keymap.set(
  "n",
  "<Space><Space>",
  "<cmd>call<space>search('<+.*+>')<CR>\"_c/+>/e<CR>",
  { desc = "Jump to next guide" }
)
vim.keymap.set(
  "v",
  "<Space><Space>",
  "<Esc><cmd>call<space>search('<+.*+>')<CR>\"_c/+>/e<CR>",
  { desc = "Jump to next guide" }
)

vim.keymap.set("n", "cn", "*``cgn", {
  desc = "Start replacing word under cursor forwards",
})
vim.keymap.set("n", "cN", "*``cgN", {
  desc = "Start replacing word under cursor backwards",
})

vim.keymap.set("v", "L", ">gv", { desc = "Indent visual selection" })
vim.keymap.set("v", "H", "<gv", { desc = "Dedent visual selection" })

vim.keymap.set("i", "<C-u>", "<Esc>viwUea", {
  desc = "Convert previous word to upper-case",
})

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", {
  desc = "Remove search match highlights",
})

vim.keymap.set("n", "gb", "<cmd>BufferLinePick<cr>", { desc = "Pick buffer" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "See :h J" })

vim.keymap.set("n", "yc", "yy<cmd>normal gcc<cr>p", {
  desc = "Paste line below and comment",
})

vim.keymap.set("i", "<C-h>", "<cmd>normal h<cr>")
vim.keymap.set("i", "<C-j>", "<cmd>normal j<cr>")
vim.keymap.set("i", "<C-k>", "<cmd>normal k<cr>")
vim.keymap.set("i", "<C-l>", "<cmd>normal l<cr>")

vim.keymap.set(
  "n",
  "<leader>cI",
  "<cmd>checkhealth vim.lsp<cr>",
  { desc = "Show LSP info" }
)

-- hydra modes
local Hydra = require("hydra")

Hydra({
  name = "Side scroll",
  mode = "n",
  body = "z",
  heads = {
    { "h", "5zh" },
    { "l", "5zl" },
    { "H", "zH" },
    { "L", "zL" },
  },
})

Hydra({
  name = "Windows",
  mode = "n",
  body = "<C-w>",
  heads = {
    { "<C-h>", "<C-w><" },
    { "<C-l>", "<C-w>>" },
    { "<C-j>", "<C-w>-" },
    { "<C-k>", "<C-w>+" },
    { "=", "<C-w>=" },
  },
})
