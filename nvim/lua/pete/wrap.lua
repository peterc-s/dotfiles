local saved_window_opts = {}
local original_opts = {}
local toggle_state = false

function _G.toggle_wrap_settings()
    if not original_opts.saved then
        -- save original state on first toggle
        original_opts.number = vim.opt.number:get()
        original_opts.textwidth = vim.opt.textwidth:get()
        original_opts.wrapmargin = vim.opt.wrapmargin:get()
        original_opts.formatoptions = vim.opt.formatoptions:get()
        original_opts.linebreak = vim.opt.linebreak:get()
        original_opts.saved = true
    end

    toggle_state = not toggle_state

    if toggle_state then
        -- apply hard wrapping settings
        vim.opt.number = true
        vim.opt.textwidth = 100
        vim.opt.wrapmargin = 0
        vim.opt.formatoptions:append("t")
        vim.opt.linebreak = true
    else
        -- restore original settings
        vim.opt.number = original_opts.number
        vim.opt.textwidth = original_opts.textwidth
        vim.opt.wrapmargin = original_opts.wrapmargin
        vim.opt.formatoptions = original_opts.formatoptions
        vim.opt.linebreak = original_opts.linebreak
    end
end

vim.keymap.set("n", "<leader>tw", "<cmd>lua toggle_wrap_settings()<CR>", { noremap = true, silent = true })
