-- import nvim-dap plugin safely
local dap_status, dap = pcall(require, "dap")
if not dap_status then
	return
end

require("nvim-dap-virtual-text").setup()
-- setup adapters
require("dap-vscode-js").setup({
	debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter",
	debugger_cmd = { "js-debug-adapter" },
	adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
})

-- dap.adapters["pwa-node"] = function(cb)
-- 	-- Launch adapter via vim.fn.jobstart or similar
-- 	-- Maybe let it bind to port 0 and use the port it bound to from stdout
-- 	cb({
-- 		type = "server",
-- 		host = "127.0.0.1",
-- 		port = 8123,
-- 	})
-- end

-- custom adapter for running tasks before starting debug
local custom_adapter = "pwa-node-custom"
dap.adapters[custom_adapter] = function(cb, config)
	if config.preLaunchTask then
		local async = require("plenary.async")
		local notify = require("notify").async

		async.run(function()
			---@diagnostic disable-next-line: missing-parameter
			notify("Running [" .. config.preLaunchTask .. "]").events.close()
		end, function()
			vim.fn.system(config.preLaunchTask)
			config.type = "pwa-node"
			dap.run(config)
		end)
	end
end

-- language config
for _, language in ipairs({ "typescript", "javascript" }) do
	dap.configurations[language] = {
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			cwd = "${workspaceFolder}",
		},
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach",
			processId = require("dap.utils").pick_process,
			cwd = "${workspaceFolder}",
		},
		{
			name = "Launch",
			type = "pwa-node",
			request = "launch",
			program = "${file}",
			rootPath = "${workspaceFolder}",
			cwd = "${workspaceFolder}",
			sourceMaps = true,
			skipFiles = { "<node_internals>/**" },
			protocol = "inspector",
			console = "integratedTerminal",
		},
		{
			name = "Attach to node process",
			type = "pwa-node",
			request = "attach",
			rootPath = "${workspaceFolder}",
			processId = require("dap.utils").pick_process,
		},
		{
			name = "Debug Main Process (Electron)",
			type = "pwa-node",
			request = "launch",
			program = "${workspaceFolder}/node_modules/.bin/electron",
			args = {
				"${workspaceFolder}/dist/index.js",
			},
			outFiles = {
				"${workspaceFolder}/dist/*.js",
			},
			resolveSourceMapLocations = {
				"${workspaceFolder}/dist/**/*.js",
				"${workspaceFolder}/dist/*.js",
			},
			rootPath = "${workspaceFolder}",
			cwd = "${workspaceFolder}",
			sourceMaps = true,
			skipFiles = { "<node_internals>/**" },
			protocol = "inspector",
			console = "integratedTerminal",
		},
		{
			name = "Debug Main Process (Electron Vite)",
			type = "pwa-node",
			request = "launch",
			program = "${workspaceFolder}/node_modules/.bin/electron-vite",
			args = {
				"--sourcemap",
			},
			rootPath = "${workspaceFolder}",
			cwd = "${workspaceFolder}",
			sourceMaps = true,
			skipFiles = { "<node_internals>/**" },
			protocol = "inspector",
			console = "integratedTerminal",
		},
		{
			name = "Compile & Debug Main Process (Electron)",
			type = custom_adapter,
			request = "launch",
			preLaunchTask = "npm run build-ts",
			program = "${workspaceFolder}/node_modules/.bin/electron",
			args = {
				"${workspaceFolder}/dist/index.js",
			},
			outFiles = {
				"${workspaceFolder}/dist/*.js",
			},
			resolveSourceMapLocations = {
				"${workspaceFolder}/dist/**/*.js",
				"${workspaceFolder}/dist/*.js",
			},
			rootPath = "${workspaceFolder}",
			cwd = "${workspaceFolder}",
			sourceMaps = true,
			skipFiles = { "<node_internals>/**" },
			protocol = "inspector",
			console = "integratedTerminal",
		},
	}
end

-- add icon style
vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#993939", bg = "#31353f" })
vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef", bg = "#31353f" })
vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379", bg = "#31353f" })

vim.fn.sign_define(
	"DapBreakpoint",
	{ text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)
vim.fn.sign_define(
	"DapBreakpointCondition",
	{ text = "ﳁ", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)
vim.fn.sign_define(
	"DapBreakpointRejected",
	{ text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)
vim.fn.sign_define(
	"DapLogPoint",
	{ text = "", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" }
)
vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" })
