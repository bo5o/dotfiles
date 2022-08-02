-------------
-- => General
-------------

-- Set <leader> key
vim.g.mapleader = ","

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

-- Height of the command bar
vim.opt.cmdheight = 1

vim.opt.whichwrap:append({ ["<"] = true, [">"] = true, h = true, l = true })

-- Python host programs
vim.g.python_host_prog = os.getenv("HOME") .. "/.virtualenvs/py2nvim/bin/python"
vim.g.python3_host_prog = os.getenv("HOME") .. "/.virtualenvs/py3nvim/bin/python"

------------------------
-- => VIM user interface
------------------------

vim.opt.showmode = false

-- Diff options
vim.opt.diffopt = { "vertical" }

-- Space to keep above, below and to the side of the cursor
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 1

-- Ignore case when searching
vim.opt.ignorecase = true

-- When searching try to be smart about cases
vim.opt.smartcase = true

-- Don't redraw while executing macros (good performance config)
vim.opt.lazyredraw = true

-- For regular expressions turn magic on
vim.opt.magic = true

-- Folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

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

-----------------------------
-- => Files, backups and undo
-----------------------------

-- Turn backup off, since most stuff is in SVN, git et.c anyway...
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

vim.opt.undofile = true

----------------------
-- => Colors and Fonts
----------------------

-- Syntax highlighting is very slow for long lines
vim.opt.synmaxcol = 256

----------------------------------
-- => Text, tab and indent related
----------------------------------

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

-- automatically highlight yanked region
local highlight_yank = vim.api.nvim_create_augroup("highlight_yank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = { "*" },
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
  end,
  group = highlight_yank,
  desc = "Highlight yanked region",
})

-- filetype/buffer settings
vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0

local terminal_settings =
  vim.api.nvim_create_augroup("terminal_settings", { clear = true })

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = { "*" },
  group = terminal_settings,
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
  desc = "Disable line numbers in terminal buffers",
})

local file_type_settings =
  vim.api.nvim_create_augroup("FileTypeSettings", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "yaml",
    "html",
    "css",
    "javascript",
    "typescript",
    "json",
    "vue",
    "tex",
    "bib",
    "xml",
  },
  group = file_type_settings,
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

-- Command to close all buffer except the current one
vim.api.nvim_create_user_command("BufOnly", [[silent! execute "%bd|e#|bd#"]], {})
