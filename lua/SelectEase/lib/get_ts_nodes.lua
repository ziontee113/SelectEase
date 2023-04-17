local M = {}

-- https://github.com/nvim-treesitter/nvim-treesitter/blob/master/lua/nvim-treesitter/parsers.lua
local filetype_to_parsername = {
    javascriptreact = "javascript",
    ecma = "javascript",
    jsx = "javascript",
    PKGBUILD = "bash",
    html_tags = "html",
    typescriptreact = "tsx",
    ["html.handlebars"] = "glimmer",
    systemverilog = "verilog",
    cls = "latex",
    sty = "latex",
    OpenFOAM = "foam",
    pandoc = "markdown",
    rmd = "markdown",
    quarto = "markdown",
    cs = "c_sharp",
    tape = "vhs",
    dosini = "ini",
    confini = "ini",
}

local get_parser_name_and_root = function()
    local lang = vim.bo[0].ft
    local parser_name = filetype_to_parsername[lang] or lang

    local parser_ok, parser = pcall(vim.treesitter.get_parser, 0, parser_name)

    if parser_ok then
        local trees = parser:parse()
        local root = trees[1]:root()

        return parser_name, root
    end
end

M.get_nodes_from_query = function(query, queries)
    local parser_name, root = get_parser_name_and_root()
    local nodes = {}

    query = queries[parser_name] or query
    if query == nil then
        return {}
    end

    local iter_query = vim.treesitter.query.parse(parser_name, query)
    for _, matches, _ in iter_query:iter_matches(root) do
        local node = matches[1]
        table.insert(nodes, node)
    end

    return nodes
end

M.get_text_from_nodes = function(nodes)
    local text_tbl = {}

    for _, node in ipairs(nodes) do
        local node_text = vim.treesitter.get_node_text(node, 0)
        table.insert(text_tbl, node_text)
    end

    return text_tbl
end

return M
