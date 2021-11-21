local null_ls = require("null-ls")
local builtins = null_ls.builtins

null_ls.config({
	debounce = 250,
	diagnostics_format = "[#{s}] #{c}: #{m}",
	sources = {
		-- Lua
		builtins.formatting.stylua,
		-- Python
		-- builtins.diagnostics.flake8,
		-- builtins.diagnostics.pylint.with({
		-- 	condition = function(utils)
		-- 		return utils.root_has_file(".pylintrc")
		-- 	end,
		-- }),
		-- builtins.diagnostics.mypy,
		builtins.formatting.black,
		builtins.formatting.isort,
		-- Javascript/Typescript/Vue
		builtins.diagnostics.eslint_d.with({
			filetypes = { "javascript", "typescript", "vue" },
		}),
		builtins.formatting.eslint_d.with({
			filetypes = { "javascript", "typescript", "vue" },
		}),
		-- CSS/HTML/JSON/YAML/Markdown
		builtins.diagnostics.yamllint,
		builtins.diagnostics.markdownlint.with({
			filetypes = { "markdown", "vimwiki" },
		}),
		builtins.formatting.prettierd.with({
			filetypes = { "css", "html", "json", "yaml", "markdown" },
		}),
		-- Dockerfile
		builtins.diagnostics.hadolint,
		-- Shell
		builtins.diagnostics.shellcheck.with({
			filetypes = { "sh", "zsh" },
		}),
		builtins.formatting.shfmt,
		-- Go
		builtins.formatting.gofmt,
		-- Tex
		builtins.diagnostics.chktex,
		-- Vim
		builtins.diagnostics.vint,
	},
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local function on_attach(client, bufnr)
	if client.resolved_capabilities.document_formatting then
		vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
	end
end

require("lspconfig")["null-ls"].setup({
	autostart = true,
	on_attach = on_attach,
	capabilities = capabilities,
})
