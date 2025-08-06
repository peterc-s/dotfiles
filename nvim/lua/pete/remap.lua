-- other remaps exist in plugin config file!

vim.keymap.set("n", "<leader>e", vim.cmd.Explore)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set('n', 'J', function()
    local count = vim.v.count + 1 or ''
    return 'mz' .. count .. 'J`z'
end, { expr = true })

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

vim.keymap.set("n", "Q", "<nop>")

vim.api.nvim_set_keymap('n', 'Q', '!!$SHELL<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'F', '!!figlet<CR>', { noremap = true })

vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<left><left><left>")
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- stop using these :)
vim.keymap.set("n", "<Up>", "<Nop>", { noremap = true })
vim.keymap.set("n", "<Left>", "<Nop>", { noremap = true })
vim.keymap.set("n", "<Right>", "<Nop>", { noremap = true })
vim.keymap.set("n", "<Down>", "<Nop>", { noremap = true })
