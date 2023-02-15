local M = {}

--=============== Text Manipulation in Buffer ===============

function M.set_lines(lines)
    if type(lines) == "string" then
        lines = vim.split(lines, "\n")
    end

    return vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end

return M
