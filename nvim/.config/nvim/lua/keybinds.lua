local map = vim.api.nvim_set_keymap
local whichkey = require("which-key")

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
			d = { "<cmd>BClose!<CR>", "Close current buffer (ignore unsaved changes)" },
		},
		x = { "<cmd>Bclose<CR>", "Close current buffer" },
		X = { "<cmd>edit#<CR>", "Re-open last closed buffer" },
		cd = { "<cmd>cd %:p:h<CR>:pwd<CR>", "Change directory to location of current file" },
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

	-- navigate quickfix relative to current cursor position
	["[d"] = { "<cmd>cabove<CR>", ":cabove" },
	["]d"] = { "<cmd>cbelow<CR>", ":cbelow" },

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

	[";dt"] = { "<C-r>=strftime('%Y-%m-%d')<CR>", "Insert current date", mode = "i" },

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
-- whichkey.register({
-- ["<Space><Space>"] = {
-- 	'<Esc>/<++><Enter>"_c4l',
-- 	"Jump to next guide",
-- 	mode = "i",
-- },
-- })

-- remap 0 to go to first non-blank character (like ^)
whichkey.register({
	["0"] = { "^", "See :h ^", mode = "v" },
})
whichkey.register({
	["0"] = { "^", "See :h ^", mode = "o" },
})

whichkey.register({
	[","] = { "<Plug>Sneak_,", "Sneak repeat" },

	cl = {
		name = "lsp",
		i = { "<cmd>LspInfo<cr>", "Lsp info" },
		r = { "<cmd>LspRestart<cr>", "Restart LSP servers" },
		a = { "<cmd>Telescope lsp_code_actions<cr>", "Show code actions" },
	},

	f = {
		name = "find",
		f = { "<cmd>Telescope find_files<cr>", "Find files" },
		F = {
			"<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files<cr>",
			"Find files (incl. hidden)",
		},
		r = { "<cmd>Telescope live_grep<cr>", "Live grep" },
		b = { "<cmd>Telescope buffers<cr>", "Find buffers" },
		m = { "<cmd>Telescope oldfiles<cr>", "Find most recently used files" },
		k = { "<cmd>Telescope keymaps<cr>", "Find keymaps" },
		s = { "<cmd>Telescope lsp_document_symbols<cr>", "Find symbols" },
		S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Find workspace symbols" },
		g = { "<cmd>Telescope git_files<cr>", "Find git files" },
		c = { "<cmd>Telescope git_bcommits<cr>", "Find git commits (file)" },
		C = { "<cmd>Telescope git_commits<cr>", "Find git commits (repo)" },
		u = { "<cmd>Telescope ultisnips<cr>", "Find snippets" },
		t = { "<cmd>TodoTelescope<cr>", "Find todos" },
	},

	g = {
		name = "git",
		["<space>"] = { "<cmd>Git<space>", "Enter git command", silent = false },
		s = { "<cmd>Git<cr>", "Status" },
		co = { "<cmd>Git checkout<cr>", "Checkout" },
		cc = { "<cmd>Git commit -v -q<cr>", "Commit" },
		-- ct = { "<cmd>Git commit -v -q %:p<cr>", "Commit" },
		ca = { "<cmd>Git commit --amend<cr>", "Amend" },
		w = { "<cmd>Gwrite<cr>", "Stage" },
		l = { "<cmd>GV<cr>", "Commit history" },
		L = { "<cmd>0Gllog<cr>", "Buffer commit history" },
		m = "Line history",
		b = { "<cmd>Gblame<cr>", "Blame" },
		e = { "<cmd>Gedit<cr>", "Edit" },
		d = { "<cmd>Gdiffsplit<cr>", "Diff" },
		D = { "<cmd>Gdiffsplit<space>", "Enter diff command", silent = false },
		p = { "<cmd>Git pull<cr>", "Pull" },
		P = { "<cmd>Git push<cr>", "Push" },
	},

	o = {
		name = "open",
		s = { "<cmd>SymbolsOutline<cr>", "Toggle symbol tree" },
		f = { "<cmd>NvimTreeToggle", "Toggle file tree" },
		F = { "<cmd>NvimTreeFindFile", "Find current file in file tree" },
		g = { "<cmd>FloatermNew lazygit<cr>", "Open lazygit" },
		r = { "<cmd>FloatermNew ranger<cr>", "Open file browser" },
		d = { "<cmd>FloatermNew lazydocker<cr>", "Open lazydocker" },
		m = { "<cmd>FloatermNew btm -m<cr>", "Open system monitor" },
		u = { "<cmd>FloatermNew ncdu<cr>", "Show disk usage" },
		l = { "<cmd>LspInstallInfo<cr>", "Open LSP installer" },
		D = { "<cmd>DBUI<cr>", "Open DBUI" },
	},

	q = {
		name = "diagnostics",
		q = { "<cmd>TroubleToggle<cr>", "List diagnostics" },
		f = { "<cmd>TroubleToggle quickfix<cr>", "Toggle quickfix" },
		l = { "<cmd>TroubleToggle loclist<cr>", "Toggle loclist" },
		t = { "<cmd>TodoTrouble<cr>", "List todos" },
	},

	s = {
		name = "replace",
		r = { "<cmd>lua require('spectre').open()<cr>", "Search and replace" },
		R = { "<cmd>lua require('spectre').open_file_search()<cr>", "Search and replace in current file" },
	},

	t = {
		name = "test",
		n = { "<cmd>TestNearest<cr>", "Run nearest test" },
		N = { "<cmd>TestNearest<space>", "Run nearest test (add flags)", silent = false },
		f = { "<cmd>TestFile<cr>", "Run test file" },
		s = { "<cmd>TestSuite<cr>", "Run test suite" },
		l = { "<cmd>TestLast<cr>", "Run last test" },
		L = { "<cmd>TestLast<space>", "Run last test (add flags)", silent = false },
		t = { "<cmd>TestLast<cr>", "Run last test" },
		g = { "<cmd>TestVisit<cr>", "Open last run test in current buffer" },
	},
}, {
	prefix = "<leader>",
})

-- harpoon
whichkey.register({
	["<BS>"] = {
		function()
			require("harpoon.ui").toggle_quick_menu()
		end,
		"Open harpoon quick menu",
	},
	m = {
		function()
			require("harpoon.mark").add_file()
		end,
		"Add file to harpoon",
	},
	n = {
		function()
			require("harpoon.ui").nav_file(1)
		end,
		"Navigate to file 1",
	},
	e = {
		function()
			require("harpoon.ui").nav_file(2)
		end,
		"Navigate to file 2",
	},
	i = {
		function()
			require("harpoon.ui").nav_file(3)
		end,
		"Navigate to file 3",
	},
	o = {
		function()
			require("harpoon.ui").nav_file(4)
		end,
		"Navigate to file 4",
	},
}, {
	prefix = "<BS>",
})

-- Send certain key combinations to g:tmux_session
map("n", "t<cr>", "<cmd>Tmux send-keys -t " .. vim.g.tmux_session .. " Enter<cr>", { noremap = true })
map("n", "t<C-c>", "<cmd>Tmux send-keys -t " .. vim.g.tmux_session .. " C-c<cr>", { noremap = true })
map("n", "t<C-d>", "<cmd>Tmux send-keys -t " .. vim.g.tmux_session .. " C-d<cr>", { noremap = true })
