return {
	-- copilot
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		suggestion = { enabled = false },
		panel = { enabled = false },
		opts = {},
	},
	{
		"zbirenbaum/copilot-cmp",
		config = function()
			require("copilot_cmp").setup()
		end,
	},
	{
		"smjonas/inc-rename.nvim",
		cmd = "IncRename",
		config = true,
	},
}
