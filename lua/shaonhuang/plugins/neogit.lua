-- import lualine plugin safely
local status, lualine = pcall(require, "neogit")
if not status then
	return
end

neogit.setup({
	integration = {
		diffview = true,
	},
})
