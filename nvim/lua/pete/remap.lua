-- other remaps exist in plugin config file!

-- LSP keymaps
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp_attach_keymaps", { clear = true }),
    callback = function(args)
        local bufnr = args.buf
        local opts = { noremap = true, silent = true, buffer = bufnr }

        -- Navigation commands
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- Go to definition
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- Go to declaration
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts) -- Go to implementation
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts) -- Find references
        vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts) -- Go to type definition

        -- Documentation
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- Show hover info
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts) -- Show signature help

        -- Code actions
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts) -- Code actions
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- Rename symbol
        -- vim.keymap.set("n", "<leader>f", function()
        -- 	vim.lsp.buf.format({ async = true })
        -- end, opts) -- Format code

        -- Diagnostics
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- Previous diagnostic
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- Next diagnostic
        vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts) -- Show diagnostic
        vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts) -- List diagnostics
    end,
    desc = "LSP: Set up keymaps",
})

-- Open file explorer
-- vim.keymap.set("n", "<leader>e", vim.cmd.Explore)
vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>")

-- Move lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Multi-join
vim.keymap.set("n", "J", function()
    local count = vim.v.count + 1 or ""
    return "mz" .. count .. "J`z"
end, { expr = true })

-- Centred scrolling/jumping
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste without yanking deleted text
vim.keymap.set("x", "<leader>p", '"_dP')

-- System clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- Delete without yanking
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')

-- Shell
vim.keymap.set("n", "Q", "<nop>")
vim.api.nvim_set_keymap("n", "Q", "!!$SHELL<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "F", "!!figlet<CR>", { noremap = true })

-- Search and replace under cursor
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<left><left><left>")

-- Make file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- leap.nvim binds
vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap)")
vim.keymap.set("n", "S", "<Plug>(leap-from-window)")

-- Open bacon terminal when in a Rust project
vim.api.nvim_create_autocmd("FileType", {
    pattern = "rust",
    group = vim.api.nvim_create_augroup("rust_bacon_terminal", { clear = true }),
    callback = function()
        local cargo_file = vim.fn.findfile("Cargo.toml", ".;")
        if cargo_file == "" then
            return
        end

        local terms = require("toggleterm.terminal").get_all()
        for _, term in pairs(terms) do
            if term.cmd == "bacon" then
                return
            end
        end

        local Terminal = require("toggleterm.terminal").Terminal
        local bacon = Terminal:new({
            cmd = "bacon",
            direction = "vertical",
            close_on_exit = false,
            auto_scroll = true,
            start_in_insert = false,
            on_open = function(term)
                vim.cmd("wincmd p")
                vim.cmd("stopinsert")
            end,
        })
        bacon:open()
    end,
    desc = "Open bacon terminal for Rust projects",
})

-- Keymap to manually toggle the bacon terminal
vim.keymap.set("n", "<leader>b", function()
    local terms = require("toggleterm.terminal").get_all()
    for _, term in pairs(terms) do
        if term.cmd == "bacon" then
            term:toggle()
            return
        end
    end
    local Terminal = require("toggleterm.terminal").Terminal
    local bacon = Terminal:new({
        cmd = "bacon",
        direction = "vertical",
        close_on_exit = false,
        auto_scroll = true,
        start_in_insert = false,
        on_open = function(term)
            vim.cmd("wincmd p")
            vim.cmd("stopinsert")
        end,
    })
    bacon:open()
end, { desc = "Toggle bacon terminal" })

-- stop using these :)
vim.keymap.set("n", "<Up>", "<Nop>", { noremap = true })
vim.keymap.set("n", "<Left>", "<Nop>", { noremap = true })
vim.keymap.set("n", "<Right>", "<Nop>", { noremap = true })
vim.keymap.set("n", "<Down>", "<Nop>", { noremap = true })
