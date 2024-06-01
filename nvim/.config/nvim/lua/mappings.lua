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

  -- jump around diagnostics
  ["]d"] = {
    function()
      vim.diagnostic.goto_next({ float = true, wrap = false })
    end,
    "Jump to the next diagnostic",
  },

  ["[d"] = {
    function()
      vim.diagnostic.goto_prev({ float = true, wrap = false })
    end,
    "Jump to the previous diagnostic",
  },

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
