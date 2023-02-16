## SelectEase.nvim

Select text using Treesitter Queries and start typing right away.

## Installation:

Example `lazy.nvim` config:

```lua
return {
    "ziontee113/SelectEase",
    config = function()
        local select_ease = require("SelectEase")

        -- example query
        local query = [[
            ;; query
            ((identifier) @cap)
            ("string_content" @cap)
            ((true) @cap)
            ((false) @cap)
        ]]

        -- next / previous node that matches the query
        vim.keymap.set({ "n", "s", "i" }, "<C-A-p>", function()
            select_ease.select_node({ query = query, direction = "previous" })
        end, {})
        vim.keymap.set({ "n", "s", "i" }, "<C-A-n>", function()
            select_ease.select_node({ query = query, direction = "next" })
        end, {})

        -- "vertical drill jump"
        vim.keymap.set({ "n", "s", "i" }, "<C-A-k>", function()
            select_ease.select_node({
                query = query,
                direction = "previous",
                vertical_drill_jump = true,
            })
        end, {})
        vim.keymap.set({ "n", "s", "i" }, "<C-A-j>", function()
            select_ease.select_node({
                query = query,
                direction = "next",
                vertical_drill_jump = true,
            })
        end, {})

        -- jump to targets only on current line
        vim.keymap.set({ "n", "s", "i" }, "<C-A-h>", function()
            select_ease.select_node({
                query = query,
                direction = "previous",
                current_line_only = true,
            })
        end, {})
        vim.keymap.set({ "n", "s", "i" }, "<C-A-l>", function()
            select_ease.select_node({
                query = query,
                direction = "next",
                current_line_only = true,
            })
        end, {})
    end,
}
```

## Feedback is always appreciated 

If you encounter any issues or have suggestions for improving the plugin, please feel free to open an issue or pull request.
