vim.cmd("colorscheme onedark")
vim.cmd(":hi statusline guibg=NONE")

-- transparent bgs
local groups = {
	"DressingInputNormal",
	"DressingInputBorder",
	"DressingInputTitle",
	"DressingSelectNormal",
	"DressingSelectBorder",
	"DressingSelectTitle",
	"MiniPickNormal",
	"MiniPickBorder",
	"MiniPickTitle",
	"MiniPickPrompt",
	"MiniPickPreview",
	"NormalFloat",
	"FloatBorder",
	"FloatTitle",
}

for _, g in ipairs(groups) do
	if vim.fn.hlexists(g) == 1 then
		vim.api.nvim_set_hl(0, g, { bg = "NONE" })
	end
end

-- rulers
vim.api.nvim_create_augroup("filetype_rulers", { clear = true })

--- filetype specific rulers
local filetype_rulers = {
	python = "79",
}

--- configure rulers per filetype
vim.api.nvim_create_autocmd("BufEnter", {
	group = "filetype_rulers",
	pattern = "*",
	callback = function()
		local ft = vim.bo.filetype
		if filetype_rulers[ft] then
			vim.opt.colorcolumn = filetype_rulers[ft]
		else
			vim.opt.colorcolumn = ""
		end
	end,
})
