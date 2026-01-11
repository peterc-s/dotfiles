local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>tf', builtin.git_files, { desc = "Telescope - git files." })
vim.keymap.set('n', '<leader>tg', builtin.live_grep, { desc = "Telescope - live grep." })
vim.keymap.set('n', '<C-b>', builtin.buffers, { desc = "Telescope - buffers." })
vim.keymap.set('n', '<leader>th', builtin.help_tags, { desc = "Telescope - help tags." })
vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = "Telescope - find files." })
