vim.g.vimtex_compiler_method = "latexmk"
vim.g.vimtex_compiler_latexmk = {
    build_method = "latexmk",
    options = { "-pdf", "-bibtex", "-interaction=nonstopmode", "-shell-escape" },
}
vim.g.vimtex_view_method = "mupdf"
