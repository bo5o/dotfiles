local null_ls = require("null-ls")
local builtins = null_ls.builtins

null_ls.config({
	sources = { builtins.formatting.stylua },
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
