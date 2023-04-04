-- import nvim-dap-ui plugin safely
local dap_ui_status, dap_ui = pcall(require, "dapui")
if not dap_ui_status then
	return
end

local dap_status, dap = pcall(require, "dap")
if not dap_status then
	return
end

-- setup for every opening debugger process to use dap-ui
dap_ui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
	dap_ui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dap_ui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dap_ui.close()
end
