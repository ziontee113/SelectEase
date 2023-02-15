local test_helpers = require("CottonCandy.test_helpers")
local module = require("CottonCandy.lib.get_node")

describe("get nodes using TS query", function()
    before_each(function()
        test_helpers.set_lines([[
local my_func = function()
    local my_num = 100
    local my_str = "This is a string"
end
        ]])
        vim.bo.ft = "lua"
    end)

    it("can get buffer's ts_nodes from ts_query, then get text from those nodes", function()
        local query = " ((identifier) @cap)"
        local expected_text_tbl = {
            "my_func",
            "my_num",
            "my_str",
        }
        local nodes = module.get_nodes_from_query(query)
        local result_text_tbl = module.get_text_from_nodes(nodes)
        assert.same(expected_text_tbl, result_text_tbl)
    end)
end)
