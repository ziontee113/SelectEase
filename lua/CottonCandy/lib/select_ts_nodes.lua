local ts_utils = require("nvim-treesitter.ts_utils")

local M = {}

M.select_node = function(node)
    ts_utils.update_selection(0, node)
end

return M
