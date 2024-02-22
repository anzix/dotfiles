local nvim_dap_status, dap = pcall(require, "dap")
if not nvim_dap_status then
	return
end

local nvim_dap_ui_status, dapui = pcall(require, "dapui")
if not nvim_dap_ui_status then
	return
end

local mason_path = vim.fn.glob(vim.fn.stdpath("data")) .. "/mason/"
local codelldb_exec_path = mason_path .. "packages/codelldb/codelldb"
dap.adapters.codelldb = {
	type = "server",
	port = "${port}",
	executable = {
		command = codelldb_exec_path,
		args = { "--port", "${port}" },

		-- On windows you may have to uncomment this:
		-- detached = false,
	},
}

dap.configurations.c = {
	{
		name = "Launch file",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
	},
}

-- If you want to use this for Rust and C, add something like this:
-- dap.configurations.c = dap.configurations.cpp
-- dap.configurations.rust = dap.configurations.cpp

dapui.setup()
dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end

-- Debugger
-- Space+dt - Добавить точку на строке (повторно убирает точку)
-- Space+dc - Запустить или продолжить отладку
-- Когда появляется действие в среднем нижнем окне nvim при шаге вперёд
-- нужно переключится на это окно и перейти в режим input
-- внутри вводим значение и Enter
vim.keymap.set("n", "<leader>dt", ":DapToggleBreakpoint<CR>")
vim.keymap.set("n", "<leader>dc", ":DapContinue<CR>")
vim.keymap.set("n", "<Leader>dx", ":DapTerminate<CR>")
vim.keymap.set("n", "<Leader>do", ":DapStepOver<CR>")
