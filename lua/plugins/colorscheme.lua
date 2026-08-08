-- Set colorscheme with no background
function ColorMyPencils(color)
	color = color or "slate"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
end

return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
	},
	{
		"vague-theme/vague.nvim",
		opts = { transparent = true },
		config = function()
			ColorMyPencils("vague")
		end,
	},
}
