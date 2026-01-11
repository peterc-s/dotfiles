vim.api.nvim_create_augroup("filetype_rulers", { clear = true })

-- filetype specific rulers
local filetype_rulers = {
    python = "80",
    tex = "100",
    markdown = "100",
}

-- configure rulers per filetype
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
