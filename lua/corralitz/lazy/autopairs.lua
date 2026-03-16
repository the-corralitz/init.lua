return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			lazy = true,
		},
		config = function()
			local autopairs = require("nvim-autopairs")
			autopairs.setup({ check_ts = true })
		end,
	},
}
