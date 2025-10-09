require("toggleterm").setup({
    open_mapping = "<C-\\>",
    size = function(term)
        if term.direction == "horizontal" then
            return 20
        elseif term.direction == "vertical" then
            return 80
        end
    end,
})
