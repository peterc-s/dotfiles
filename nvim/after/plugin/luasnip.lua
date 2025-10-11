local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- LaTeX Snippets
-- ls.add_snippets("tex", {
--     s("\\figure", {
--         t("\\begin{figure}"),
--         t({ "", "    \\centering" }),
--         t({ "", "    \\caption{" }), i(1, ""), t("}"),
--         t({ "", "    \\label{" }), i(2, "fig:"), t("}"),
--         t({ "", "\\end{figure}" }),
--         i(0),
--     }),
-- })

-- MD snippets
-- presenterm
ls.add_snippets("markdown", {
    s("\\p", {
        t("<!--pause-->"),
        i(0),
    }),
})

ls.add_snippets("markdown", {
    s("\\jump", {
        t("<!--jump_to_middle-->"),
        i(0),
    }),
})
