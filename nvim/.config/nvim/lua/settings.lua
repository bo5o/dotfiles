-- Rich colors
vim.opt.termguicolors = true

-- Decrease update time
vim.opt.updatetime = 100
vim.opt.timeoutlen = 500

-- Line number style
vim.opt.relativenumber = true
vim.opt.number = true

-- Set clipboard register
vim.opt.clipboard = "unnamedplus"

-- Enable mouse in normal mode
vim.opt.mouse = "n"

-- Highlight current line
vim.opt.cursorline = true

-- Highlight column at 88 chars
vim.opt.colorcolumn = "88"
vim.opt.textwidth = 88

-- Height of the command bar
vim.opt.cmdheight = 1

vim.opt.whichwrap:append({ ["<"] = true, [">"] = true, h = true, l = true })

-- Python provider configuration
vim.g.python3_host_prog = os.getenv("MISE_DATA_DIR")
  .. "/installs/python/3.13.5/bin/python"

vim.opt.showmode = false

-- Diff options
vim.opt.diffopt = {
  "internal",
  "filler",
  "closeoff",
  "vertical",
  "indent-heuristic",
  "linematch:60",
  "algorithm:histogram",
}

vim.opt.fillchars:append({ diff = "⟋" })

-- Space to keep above, below and to the side of the cursor
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 1

-- Ignore case when searching
vim.opt.ignorecase = true

-- When searching try to be smart about cases
vim.opt.smartcase = true

-- Don't redraw while executing macros (good performance config)
vim.opt.lazyredraw = false

-- For regular expressions turn magic on
vim.opt.magic = true

-- Folding
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client ~= nil and client:supports_method("textDocument/foldingRange") then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
    end
  end,
})

vim.opt.foldenable = false
vim.opt.foldlevelstart = 99

-- Show matching brackets when text indicator is over them
vim.opt.showmatch = true
-- How many tenths of a second to blink when matching brackets
vim.opt.matchtime = 2

-- No annoying sound on errors
vim.opt.errorbells = false
vim.opt.visualbell = false

-- More natural split opening
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Don't give |ins-completion-menu| messages.  For example,
-- '-- XXX completion (YYY)', 'match 1 of 2', 'The only match',
vim.opt.shortmess:append("c")

vim.opt.completeopt = { "noinsert", "menuone", "noselect" }

vim.opt.signcolumn = "yes"

-- View options for saving/restoring views
vim.opt.viewoptions = { "cursor", "folds" }

-- Don't open folds when moving through paragraphs
vim.opt.foldopen:remove("block")

-- Enable the wild menu
vim.opt.wildmode = { "longest", "list", "full" }
vim.opt.wildignore = { "*.o", "*~", "*.pyc", "*.mat", "*.pdfpc", "*.sls", "*.so" }
vim.opt.wildignore:append({
  "*.swp",
  "*.aux",
  "*.gz",
  "*.fdb_latexmk",
  "*.fls",
  "*.bbl",
})
vim.opt.wildignore:append({ "*.log", "*.pdf", "*.glg", "*.glo", "*.ist", "*.bcf" })
vim.opt.wildignore:append({ "*.blg", "*.gls", "*.run.xml", "*.toc", "*.acn", "*.acr" })
vim.opt.wildignore:append({ "*.alg", "*.ntn", "*.slo", "*.not", "*.nlg", "*.slg" })
vim.opt.wildignore:append({ "*.lof", "*.lot", "*.lol", "*.xdv", "tags", "*.zip" })
vim.opt.wildignore:append({ "**/.direnv/**", "**/.venv/**", "**/.tools/**", "*/tmp/*" })

-- Turn backup off, since most stuff is in SVN, git et.c anyway...
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

vim.opt.undofile = true

-- Syntax highlighting is very slow for long lines
vim.opt.synmaxcol = 256

-- Use spaces instead of tabs
vim.opt.expandtab = true

-- 1 tab == 4 spaces
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

vim.opt.smartindent = true
vim.opt.wrap = false -- don't wrap lines

-- toggle invisible characters
vim.opt.list = true
vim.opt.listchars =
  { tab = "→ ", eol = "¬", trail = "⋅", extends = "❯", precedes = "❮" }
vim.opt.showbreak = "↪"

vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
    numhl = {
      [vim.diagnostic.severity.WARN] = "DiagnosticWarn",
      [vim.diagnostic.severity.ERROR] = "DiagnosticError",
      [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
      [vim.diagnostic.severity.HINT] = "DiagnosticHint",
    },
  },
  float = {
    border = "rounded",
    source = true,
  },
})
