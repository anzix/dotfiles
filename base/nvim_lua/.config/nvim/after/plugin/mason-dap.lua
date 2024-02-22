local mason_dap_nvim_status, mason_nvim_dap = pcall(require, "mason-nvim-dap")
if not mason_dap_nvim_status then
	return
end

mason_nvim_dap.setup({
	ensure_installed = {
		"codelldb",
	},
	auto_update = false,
	run_on_start = false,
	automatic_setup = true,
	handlers = nil,
})

