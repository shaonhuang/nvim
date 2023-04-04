-- import neogit plugin safely
local status, neogit = pcall(require, "neogit")
if not status then
	return
end

neogit.setup({
	integration = {
		diffview = true,
	},
})
