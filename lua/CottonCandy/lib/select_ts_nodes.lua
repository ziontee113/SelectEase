local ts_utils = require("nvim-treesitter.ts_utils")
local lib_ts_nodes = require("CottonCandy.lib.ts_nodes")

local M = {}

local select_node = function(node)
    ts_utils.update_selection(0, node)
    vim.cmd("norm! ")
end

M.select_previous_or_next_node_with_query = function(query, direction)
    local nodes = lib_ts_nodes.get_nodes_from_query(query)
    local cursor = vim.api.nvim_win_get_cursor(0)
    local cursor_row, cursor_col = cursor[1] - 1, cursor[2]

    if direction == "next" then
        for _, node in ipairs(nodes) do
            local start_row, start_col, _, _ = node:range()
            if cursor_row <= start_row then
                if cursor_row == start_row and cursor_col < start_col then
                    select_node(node)
                    break
                end
            end
        end
    elseif direction == "previous" then
        for i = #nodes, 1, -1 do
            local node = nodes[i]
            local _, _, end_row, end_col = node:range()
            if cursor_row >= end_row then
                if cursor_row == end_row and cursor_col > end_col then
                    select_node(node)
                    break
                end
            end
        end
    end
end

return M
