local mason_status, mason = pcall(require, "mason")
if not mason_status then
	return
end

local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
	return
end

local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
	return
end

mason.setup()

-- LSP
mason_lspconfig.setup({
	ensure_installed = {
		"bashls", -- bash-language-server
		"clangd", -- C
		-- 'rust_analyzer', -- Rust
		-- 'gopls', -- Go
		"emmet_ls", -- доп. lsp
		"lua_ls", -- Lua
		"html", -- html-lsp
		"jsonls", -- json
		"cssls", -- css
		"yamlls", -- yaml
		-- 'tsserver' -- typesript
	},
})

-- Форматтеры/Линтеры-Диагностеры
mason_null_ls.setup({
	ensure_installed = {
		"codelldb", -- C/C++ & Rust Debugger
		"djlint", -- htmldjango
		"stylua", -- lua formatter
		"prettier", -- markdown formatter
		"markdownlint", -- markdown diagnostic
		"shfmt", -- bash script formatter
		"shellcheck", -- диагностика для скриптов bash
	},
})
