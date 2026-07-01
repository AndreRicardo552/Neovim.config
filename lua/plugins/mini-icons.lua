return {
	"nvim-mini/mini.icons",
	version = "*",
	opts = {},
	config = function()
		require("mini.icons").setup()
		MiniIcons.mock_nvim_web_devicons()
	end,
}
