local test_helpers = require("CottonCandy.test_helpers")
local module = require("CottonCandy.lib.select_ts_nodes")

describe("select prev / next ts_node in query", function()
    it("works when nodes in the same line", function()
        -- variables
        local query = "((identifier) @cap)"

        -- setup
        test_helpers.set_lines("my_func(arg1, arg2, arg3, arg4, arg5)")
        vim.bo.ft = "lua"

        -- go to `arg2`
        vim.cmd("norm! f2")

        -- want to select `arg3` and replace with `modded_arg3`
        module.select_previous_or_next_node_with_query(query, "next")
        vim.cmd("norm! modded_arg3")

        assert.equals(
            "my_func(arg1, arg2, modded_arg3, arg4, arg5)",
            test_helpers.get_all_lines(true)
        )

        -- want to select `arg4` and replace with `modded_arg4`
        module.select_previous_or_next_node_with_query(query, "next")
        vim.cmd("norm! modded_arg4")

        assert.equals(
            "my_func(arg1, arg2, modded_arg3, modded_arg4, arg5)",
            test_helpers.get_all_lines(true)
        )

        -- want to select `modded_arg3` and replace with `further_modded_arg3`
        module.select_previous_or_next_node_with_query(query, "previous")
        vim.cmd("norm! further_modded_arg3")

        assert.equals(
            "my_func(arg1, arg2, further_modded_arg3, modded_arg4, arg5)",
            test_helpers.get_all_lines(true)
        )
    end)
end)
