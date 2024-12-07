local whichkey = require("which-key")

-- stylua: ignore start

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set("c", "<C-p>", "<Up>", { desc = "Search command history up", silent = false })
vim.keymap.set("c", "<C-n>", "<Down>", { desc = "Search command history down", silent = false })

vim.keymap.set("n", "<leader>w", "<cmd>w!<CR>", { desc = "Save buffer to current file" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to the left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to the below window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to the above window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to the right window" })

vim.keymap.set("n", "<C-w>_", "<C-w>-", { desc = "Decrease height" })
vim.keymap.set("n", "<C-w>-", "<C-w>s", { desc = "Split window" })
vim.keymap.set("n", "<C-w>|", "<C-w>v", { desc = "Split window vertically" })

vim.keymap.set("n", "<C-w>pc", "<cmd>pclose<CR>", { desc = 'Close any "Preview" window currently open' })
vim.keymap.set("n", "<C-w>C", "<cmd>tabclose<CR>", { desc = "Close current tab page" })
vim.keymap.set("n", "<C-w>O", "<cmd>tabonly<CR>", { desc = "Close all other tab pages" })
vim.keymap.set("n", "<C-w><C-f>", "<C-w>vgf", { desc = "Open file under cursor in vertical split" })

vim.keymap.set("n", "<leader>ba", "<cmd>bufdo bd<CR>", { desc = "Close all buffers" })
vim.keymap.set("n", "<leader>bo", "<cmd>BufOnly<CR>", { desc = "Close all buffers (except active buffer)" })

vim.keymap.set("n", "<leader>X", "<cmd>edit#<CR>", { desc = "Re-open last closed buffer" })
vim.keymap.set("n", "<leader>cd", "<cmd>cd %:p:h<CR>:pwd<CR>", { desc = "Change directory to location of current file" })

-- keep screen centered when moving through search results
vim.keymap.set("n", "n", "nzzzv", { desc = "See :h n" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "See :h N" })

-- undo break points
vim.keymap.set("i", ",", ",<C-g>u", { desc = "See :h ," })
vim.keymap.set("i", ".", ".<C-g>u", { desc = "See :h ." })
vim.keymap.set("i", "!", "!<C-g>u", { desc = "See :h !" })
vim.keymap.set("i", "?", "?<C-g>u", { desc = "See :h ?" })

vim.keymap.set("v", "J", "<cmd>move '>+1<cr>gv=gv", { desc = "Move visual selection down" })
vim.keymap.set("v", "K", "<cmd>move '<-2<cr>gv=gv", { desc = "Move visual selection up" })

vim.keymap.set("i", "jk", "<ESC>", { desc = "Switch to normal mode" })

-- jump around diagnostics
vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next({ float = false, wrap = false }) end, { desc = "Jump to the next diagnostic" })
vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev({ float = false, wrap = false }) end, { desc = "Jump to the previous diagnostic" })

-- ask before jumping tag stack if ambigous
vim.keymap.set("n", "C-]", "g<C-]>", { desc = "See :h CTRL-]" })

-- remap 0 to go to first non-blank character (like ^)
vim.keymap.set({ "n", "v", "o" }, "0", "^", { desc = "See :h ^" })

-- navigate with custom guides
vim.keymap.set("n", "<Space><Space>", "<cmd>call<space>search('<+.*+>')<CR>\"_c/+>/e<CR>", { desc = "Jump to next guide" })
vim.keymap.set("v", "<Space><Space>", "<Esc><cmd>call<space>search('<+.*+>')<CR>\"_c/+>/e<CR>", { desc = "Jump to next guide" })

vim.keymap.set("n", "cn", "*``cgn", { desc = "Start replacing word under cursor forwards" })
vim.keymap.set("n", "cN", "*``cgN", { desc = "Start replacing word under cursor backwards" })

vim.keymap.set("v", "L", ">gv", { desc = "Indent visual selection" })
vim.keymap.set("v", "H", "<gv", { desc = "Dedent visual selection" })

vim.keymap.set("i", "<C-u>", "<Esc>viwUea", { desc = "Convert previous word to upper-case" })

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Remove search match highlights" })

vim.keymap.set("n", "gb", "<cmd>BufferLinePick<cr>", { desc = "Pick buffer" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "See :h J" })

vim.keymap.set("n", "yc", "yy<cmd>normal gcc<cr>p", { desc = "Paste line below and comment" })

-- stylua: ignore end

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

do
  local shared = require("nvim-treesitter.textobjects.shared")
  local swap = require("nvim-treesitter.textobjects.swap")
  local ts_utils = require("nvim-treesitter.ts_utils")

  local query_string = "@parameter.inner"

  local function get_or_create_namespace()
    return vim.api.nvim_create_namespace("hydra_swap_hl_node")
  end

  local function clear_highlight()
    local hl_ns = get_or_create_namespace()
    vim.api.nvim_buf_clear_namespace(0, hl_ns, 0, -1)
  end

  local function update_highlight(range)
    local hl_ns = get_or_create_namespace()
    local hl_group = "IncSearch"
    local start = { range[1], range[2] }
    local finish = { range[3], range[4] }
    vim.highlight.range(0, hl_ns, hl_group, start, finish)
  end

  local function set_cursor_on_node(node)
    local row, col, _ = node:start()
    vim.api.nvim_win_set_cursor(0, { row + 1, col })
  end

  local function select_nth(n)
    local _, _, node = shared.textobject_at_point(query_string)
    if not node then
      return
    end

    node = node:parent():named_child(n)
    if not node then
      return
    end

    set_cursor_on_node(node)
    clear_highlight()
  end

  local function choose_adjacent(forward)
    local _, _, node = shared.textobject_at_point(query_string)
    if not node then
      return
    end

    node = shared.get_adjacent(forward, node, query_string, nil, true)
    if not node then
      return
    end

    set_cursor_on_node(node)
    clear_highlight()
  end

  local function get_siblings_for_edit(node)
    local ranges, texts = {}, {}
    for sibling in node:parent():iter_children() do
      if sibling:named() then
        ranges[#ranges + 1] = ts_utils.node_to_lsp_range(sibling)
        texts[#texts + 1] = vim.treesitter.get_node_text(sibling, 0)
      end
    end
    return ranges, texts
  end

  local function sort_nodes(reverse)
    local _, _, node = shared.textobject_at_point(query_string)
    if not node then
      return
    end

    local ranges, texts = get_siblings_for_edit(node)

    table.sort(texts, function(a, b)
      if reverse then
        return a > b
      end
      return a < b
    end)

    local edits = {}
    for i, range in ipairs(ranges) do
      edits[#edits + 1] = { range = range, newText = texts[i] }
    end

    vim.lsp.util.apply_text_edits(edits, 0, "utf-8")

    clear_highlight()
  end

  local function reverse_nodes()
    local _, _, node = shared.textobject_at_point(query_string)
    if not node then
      return
    end

    local ranges, texts = get_siblings_for_edit(node)

    local edits = {}
    for i, range in ipairs(ranges) do
      edits[#edits + 1] = { range = range, newText = texts[#texts + 1 - i] }
    end

    vim.lsp.util.apply_text_edits(edits, 0, "utf-8")

    clear_highlight()
  end

  Hydra({
    name = "Swap",
    mode = "n",
    body = "gs",
    heads = {
      -- stylua: ignore start
      { "j", function() choose_adjacent(true) end },
      { "k", function() choose_adjacent(false) end, { desc = "choose" } },
      { "h", function() swap.swap_previous(query_string) end },
      { "l", function() swap.swap_next(query_string) end, { desc = "swap" } },
      { "1", function() select_nth(0) end },
      { "2", function() select_nth(1) end },
      { "3", function() select_nth(2) end },
      { "4", function() select_nth(3) end },
      { "5", function() select_nth(4) end },
      { "6", function() select_nth(5) end },
      { "7", function() select_nth(6) end },
      { "8", function() select_nth(7) end },
      { "9", function() select_nth(8) end, { desc = "select" } },
      { "s", function() sort_nodes(false) end },
      { "S", function() sort_nodes(true) end, { desc = "sort" } },
      { "r", function() reverse_nodes() end, { desc = "reverse" } },
      { "<Esc>", nil, { color = "blue" } },
      -- stylua: ignore end
    },
    config = {
      invoke_on_body = true,
      on_key = function()
        local _, range, _ = shared.textobject_at_point(query_string)
        if not range then
          return
        end

        update_highlight(range)
      end,
      on_exit = clear_highlight,
    },
  })
end
