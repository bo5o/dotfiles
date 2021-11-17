local g = vim.g
g["airline#extensions#ale#enabled"] = 1
g.ale_virtual_text_cursor = 1
g.ale_lint_on_text_changed = 0
g.ale_lint_on_save = 1
g.ale_lint_on_enter = 1
g.ale_fix_on_save = 1
g.ale_set_loclist = 0
g.ale_set_quickfix = 1
g.ale_echo_msg_format = "[%linter%] %code%: %s"
g.ale_sign_error = ""
g.ale_sign_warning = ""
g.ale_sign_info = ""

local options = { ale_linters = {}, ale_fixers = {} }
g.ale_pattern_options = {
	[".min.js$"] = options,
	[".min.css$"] = options,
	[".git/(?!COMMIT_EDITMSG)$"] = options,
	["site-packages/.*$"] = options,
	["node_modules/.*$"] = options,
	["crontab$"] = { ale_linters = {}, ale_fixers = { "trim_whitespace" } },
}

g.ale_linters = {
	Dockerfile = {},
	gitcommit = { "gitlint" },
	javascript = {},
	json = { "jsonlint" },
	python = {},
	sh = { "bashate" },
	sql = { "sqlint" },
	tex = {},
	markdown = {},
	vimwiki = {},
	typescript = {},
	vim = {},
	vue = {},
	xml = { "xmllint" },
	yaml = {},
	zsh = {},
}

g.ale_fixers = {
	["*"] = { "remove_trailing_lines", "trim_whitespace" },
	css = {},
	html = {},
	markdown = {},
	htmldjango = { "html-beautify" },
	javascript = {},
	json = {},
	go = {},
	sh = {},
	sql = { "pgformatter" },
	tex = { "latexindent" },
	typescript = {},
	vue = {},
	yaml = {},
}
