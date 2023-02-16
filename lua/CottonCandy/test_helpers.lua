local M = {}

--- It finds `start_row, start_col, end_row, end_col` of the current visual selection,
---- adjusts the columns if the selection mode is in "V" (visual line) mode,
---- swaps *start* and *end* positions if *start* is larger than *end*.
--- Returns `start_row, start_col, end_row, end_col` in a *tuple*.
M.get_visual_range = function()
    local start_row, start_col = vim.fn.line("v"), vim.fn.col("v")
    local end_row, end_col = vim.fn.line("."), vim.fn.col(".")

    if vim.fn.mode() == "V" then
        start_col, end_col = 1, vim.fn.col("$") - 1
    end

    if start_row > end_row then
        start_row, end_row = end_row, start_row
    end

    if start_row == end_row and start_col > end_col then
        start_col, end_col = end_col, start_col
    end

    return start_row, start_col, end_row, end_col
end

--- Returns current visual selection's contents in lines (table of strings)
M.get_selection_lines = function()
    local start_row, start_col, end_row, end_col = M.get_visual_range()
    return vim.api.nvim_buf_get_text(0, start_row - 1, start_col - 1, end_row - 1, end_col, {})
end

--- Returns the content (string) of the current visual selection
M.get_selection_text = function(opts)
    opts = opts or {}
    local lines = M.get_selection_lines()

    return table.concat(lines, "\n")
end

--=============== Text Manipulation in Buffer ===============

M.set_lines = function(lines)
    if type(lines) == "string" then
        lines = vim.split(lines, "\n")
    end

    return vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end

---if `as_str`, return a string, otherwise return table
---@param as_str boolean
---@return string|table
M.get_all_lines = function(as_str)
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

    if as_str then
        return table.concat(lines, "\n")
    else
        return lines
    end
end

return M
