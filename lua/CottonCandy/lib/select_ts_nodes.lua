local lib_ts_nodes = require("CottonCandy.lib.ts_nodes")
local lib_select_mode = require("CottonCandy.lib.select_mode")

local M = {}

local select_node = function(node)
    local start_row, start_col, end_row, end_col = node:range()
    lib_select_mode.any_select({ start_row, start_col }, { end_row, end_col })
end

M.select_node = function(opts)
    local nodes = lib_ts_nodes.get_nodes_from_query(opts.query)
    local cursor = vim.api.nvim_win_get_cursor(0)
    local cursor_row, cursor_col = cursor[1] - 1, cursor[2]

    if opts.direction == "next" then
        for _, node in ipairs(nodes) do
            local start_row, start_col, _, _ = node:range()
            if cursor_row == start_row and cursor_col < start_col then
                select_node(node)
                break
            end
            if not opts.current_line_only and (cursor_row < start_row) then
                select_node(node)
                break
            end
        end
    elseif opts.direction == "previous" then
        for i = #nodes, 1, -1 do
            local node = nodes[i]
            local start_row, start_col, _, _ = node:range()
            if cursor_row == start_row and cursor_col > start_col then
                select_node(node)
                break
            end
            if not opts.current_line_only and (cursor_row > start_row) then
                select_node(node)
                break
            end
        end
    end
end

local identifier_query = "((identifier) @cap)"
local string_content_query = '("string_content" @cap)'

vim.keymap.set({ "n", "s", "i" }, "<C-A-k>", function()
    M.select_node({ query = identifier_query, direction = "previous" })
end, {})
vim.keymap.set({ "n", "s", "i" }, "<C-A-j>", function()
    M.select_node({ query = identifier_query, direction = "next" })
end, {})
vim.keymap.set({ "n", "s", "i" }, "<C-A-h>", function()
    M.select_node({ query = string_content_query, direction = "previous" })
end, {})
vim.keymap.set({ "n", "s", "i" }, "<C-A-l>", function()
    M.select_node({ query = string_content_query, direction = "next" })
end, {})

return M

-- {{{nvim-execute-on-save}}}
