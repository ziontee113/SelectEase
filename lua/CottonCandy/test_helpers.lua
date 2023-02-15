local M = {}

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
