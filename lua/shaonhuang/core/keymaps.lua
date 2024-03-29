vim.g.mapleader = " "

local keymap = vim.keymap

---------------------
-- General Keymaps
---------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>")

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>") -- increment
keymap.set("n", "<leader>-", "<C-x>") -- decrement

keymap.set("n", "<leader>+", "<C-a>") -- increment
keymap.set("n", "<leader>-", "<C-x>") -- decrement

keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window

keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") --  go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") --  go to previous tab

----------------------
-- Plugin Keybinds
----------------------

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle split window maximization

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>") -- toggle file explorer

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags

-- neogit diffview
keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>")
keymap.set("n", "<leader>gl", "<cmd>Neogit log<cr>")
keymap.set("n", "<leader>gp", "<cmd>Neogit push<cr>")
keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<cr>")
keymap.set("n", "<leader>gc", "<cmd>DiffviewClose<cr>")
keymap.set("n", "<leader>gD", "<cmd>DiffviewOpen master<cr>")

-- debugger dap dap-ui require plug notify
-- -- Set breakpoints, get variable values, step into/out of functions, etc.
keymap.set("n", "<Leader>dl", function()
	require("dap.ui.widgets").hover()
end)
keymap.set("n", "<leader>dc", "<cmd>DapContinue<CR>")
keymap.set("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>")
keymap.set("n", "<Leader>lp", function()
	require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end)
keymap.set("n", "<leader>dn", "<cmd>DapStepOver<CR>")
keymap.set("n", "<leader>di", "<cmd>DapStepInto<CR>")
keymap.set("n", "<leader>do", "<cmd>DapStepOut<CR>")
keymap.set("n", "<leader>dC", function()
	dap.clear_breakpoints()
	require("notify")("Breakpoints cleared", "warn", { title = "Dap cleared" })
end)

-- Close debugger and clear breakpoints
keymap.set("n", "<leader>de", function()
	require("dap").clear_breakpoints()
	require("dap").terminate()
	require("notify")("Debugger session ended", "warn", { title = "Dap Terminate" })
end)

-- flod code
keymap.set("n", "zA", "<cmd>set foldmethod=indent<CR>")
