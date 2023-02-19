## SelectEase.nvim

Select text using Treesitter Queries and start typing right away.

https://user-images.githubusercontent.com/102876811/219462863-d004636c-f7b6-4556-8cc6-45845b3aa668.mp4

---------------------------------------------------------------------------------

SelectEase is a tool designed to identify all nodes that match a query and select the relevant target
from the cursor, all in Select Mode. Its purpose is to efficiently locate nodes near the cursor
and enable the user to easily edit that node by typing over it.

Vim's Select Mode allows you to type over a visual selection instead of using commands
to delete or clear it, making text editing more efficient in certain cases.

## Word of Caution:

Please be aware that this plugin is still in an experimental stage and may exhibit unexpected behavior.
Your feedback and suggestions are welcome and please feel free to create issues or pull requests on the project's GitHub repository.
I appreciate your willingness to try it out the plugin and share your thoughts.

## Installation:

Example `lazy.nvim` config:

```lua
return {
    "ziontee113/SelectEase",
    config = function()
        local select_ease = require("SelectEase")

        local lua_query = [[
            ;; query
            ((identifier) @cap)
            ("string_content" @cap)
            ((true) @cap)
            ((false) @cap)
        ]]
        local python_query = [[
            ;; query
            ((identifier) @cap)
            ((string) @cap)
        ]]

        local queries = {
            lua = lua_query,
            python = python_query,
        }

        vim.keymap.set({ "n", "s", "i" }, "<C-A-k>", function()
            select_ease.select_node({
                queries = queries,
                direction = "previous",
                vertical_drill_jump = true,
                -- visual_mode = true, -- if you want Visual Mode instead of Select Mode
                fallback = function()
                    -- if there's no target, this function will be called
                    select_ease.select_node({ queries = queries, direction = "previous" })
                end,
            })
        end, {})
        vim.keymap.set({ "n", "s", "i" }, "<C-A-j>", function()
            select_ease.select_node({
                queries = queries,
                direction = "next",
                vertical_drill_jump = true,
                -- visual_mode = true, -- if you want Visual Mode instead of Select Mode
                fallback = function()
                    -- if there's no target, this function will be called
                    select_ease.select_node({ queries = queries, direction = "next" })
                end,
            })
        end, {})

        vim.keymap.set({ "n", "s", "i" }, "<C-A-h>", function()
            select_ease.select_node({
                queries = queries,
                direction = "previous",
                current_line_only = true,
                -- visual_mode = true, -- if you want Visual Mode instead of Select Mode
            })
        end, {})
        vim.keymap.set({ "n", "s", "i" }, "<C-A-l>", function()
            select_ease.select_node({
                queries = queries,
                direction = "next",
                current_line_only = true,
                -- visual_mode = true, -- if you want Visual Mode instead of Select Mode
            })
        end, {})

        -- previous / next node that matches query
        vim.keymap.set({ "n", "s", "i" }, "<C-A-p>", function()
            select_ease.select_node({ queries = queries, direction = "previous" })
        end, {})
        vim.keymap.set({ "n", "s", "i" }, "<C-A-n>", function()
            select_ease.select_node({ queries = queries, direction = "next" })
        end, {})
    end,
}
```

## Feedback is always appreciated 

If you encounter any issues or have suggestions for improving the plugin, please feel free to open an issue or pull request.
