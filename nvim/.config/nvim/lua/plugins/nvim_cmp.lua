local lspkind = require("lspkind")
lspkind.init()

local cmp = require("cmp")

local has_any_words_before = function()
	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
		return false
	end
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local press = function(key)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), "n", true)
end

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["UltiSnips#Anon"](args.body)
		end,
	},

	mapping = {
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-f>"] = cmp.mapping.scroll_docs(-4),
		["<C-e>"] = cmp.mapping.close(),

		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		}),

		["<C-Space>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				if vim.fn["UltiSnips#CanExpandSnippet"]() == 1 then
					return press("<C-R>=UltiSnips#ExpandSnippet()<CR>")
				end

				cmp.select_next_item()
			elseif has_any_words_before() then
				press("<Space>")
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),

		["<Tab>"] = cmp.mapping(function(fallback)
			if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
				press("<ESC>:call UltiSnips#JumpForwards()<CR>")
			elseif cmp.visible() then
				cmp.select_next_item()
			elseif has_any_words_before() then
				press("<Tab>")
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
				press("<ESC>:call UltiSnips#JumpBackwards()<CR>")
			elseif cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
	},

	sources = {
		{ name = "nvim_lua" },
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "ultisnips" },
		{
			name = "buffer",
			keyword_length = 4,
			opts = {
				get_bufnrs = function()
					return vim.api.nvim_list_bufs()
				end,
			},
		},
		{
			name = "tmux",
			keyword_length = 5,
			opts = {
				all_panes = true,
				trigger_characters = {},
			},
		},
	},

	formatting = {
		format = lspkind.cmp_format({
			with_text = true,
			menu = {
				nvim_lua = "[api]",
				nvim_lsp = "[lsp]",
				path = "[path]",
				ultisnips = "[snip]",
				buffer = "[buf]",
				tmux = "[tmux]",
			},
		}),
	},

	experimental = {
		native_menu = false,
		ghost_text = true,
	},
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on(
	"confirm_done",
	cmp_autopairs.on_confirm_done({
		map_char = {
			all = "(",
			tex = "{",
		},
	})
)

-- Add vim-dadbod-completion in sql files
vim.cmd([[
  augroup DadbodSql
    au!
    autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer { sources = { { name = 'vim-dadbod-completion' } } }
  augroup END
]])
