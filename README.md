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

        -- For more language support check the `Queries` section
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

## Queries
<details><summary>Rust</summary>

```lua
local rust_query = [[
    ;; query
    ((boolean_literal) @cap)
    ((string_literal) @cap)

    ; Identifiers
    ((identifier) @cap)
    ((field_identifier) @cap)
    ((field_expression) @cap)
    ((scoped_identifier) @cap)
    ((unit_expression) @cap)

    ; Types
    ((reference_type) @cap)
    ((primitive_type) @cap)
    ((type_identifier) @cap)
    ((generic_type) @cap)

    ; Calls
    ((call_expression) @cap)
]]
```
</details>

<details><summary>Golang</summary>

```lua
local go_query = [[
    ;; query
    ((selector_expression) @cap) ; Method call
    ((field_identifier) @cap) ; Method names in interface

    ; Identifiers
    ((identifier) @cap)
    ((expression_list) @cap) ; pseudo Identifier
    ((int_literal) @cap)
    ((interpreted_string_literal) @cap)

    ; Types
    ((type_identifier) @cap)
    ((pointer_type) @cap)
    ((slice_type) @cap)

    ; Keywords
    ((true) @cap)
    ((false) @cap)
    ((nil) @cap)
]]
```
</details>


<details><summary>C/C++</summary>

```lua
local c_query = [[
    ;; query
    ((string_literal) @cap)
    ((system_lib_string) @cap)

    ; Identifiers
    ((identifier) @cap)
    ((struct_specifier) @cap)
    ((type_identifier) @cap)
    ((field_identifier) @cap)
    ((number_literal) @cap)
    ((unary_expression) @cap)
    ((pointer_declarator) @cap)

    ; Types
    ((primitive_type) @cap)

    ; Expressions
    (assignment_expression
     right: (_) @cap)
]]
local cpp_query = [[
    ;; query

    ; Identifiers
    ((namespace_identifier) @cap)
]] .. c_query
```

## Feedback is always appreciated 

If you encounter any issues or have suggestions for improving the plugin, please feel free to open an issue or pull request.
