local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end

local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
	return
end

local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
local lsp_attach = function(_, bufnr)
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

mason_lspconfig.setup_handlers({
	function(server_name)
		lspconfig[server_name].setup({
			on_attach = lsp_attach,
			capabilities = lsp_capabilities,
		})
	end,
})


local bufopts = { noremap = true, silent = true }
-- LSP Buffer Keybinds are set here
vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts) -- Для темно синих и ярко синих в синтаксисе
vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts) -- Для ярко синих в синтаксисе
vim.keymap.set("n", "gI", vim.lsp.buf.implementation, bufopts)
vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, bufopts)
vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, bufopts)
vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, bufopts)
-- vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, bufopts)
vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, bufopts)
-- LSP Diagnostic Keybinds are set here
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, bufopts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, bufopts)
vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, bufopts)


-- Fix Undefined global 'vim'
lspconfig.lua_ls.setup({
	on_attach = lsp_attach,
	capabilities = lsp_capabilities,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

-- lspconfig.rust_analyzer.setup({
--     on_attach = lsp_attach,
--     capabilities = lsp_capabilities,
--     cmd = {
--         "rustup", "run", "stable", "rust-analyzer",
--     },
--     settings = {
--         ["rust-analyzer"] = {
--             diagnostics = {
--                 enable = true;
--             }
--         }
--     }
-- })

lspconfig.bashls.setup {
  on_attach = lsp_attach,
  capabilities = lsp_capabilities,
  filetypes = { 'sh', 'zsh', 'zshrc', 'bash', 'inc', 'command', 'zsh_*' },
  settings = {
    bashIde = {
      globPattern = "**/*@(.sh|.inc|.bash|.command|.zshrc|.zsh|zsh_*)"
    }
  }
}
