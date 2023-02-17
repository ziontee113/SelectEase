local M = {}

-- Copied from https://github.com/L3MON4D3/LuaSnip/blob/master/lua/luasnip/util/util.lua

function M.replace_feedkeys(keys, opts)
    vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes(keys, true, false, true),
        -- folds are opened manually now, no need to pass t.
        -- n prevents langmap from interfering.
        opts or "n",
        true
    )
end

-- pos: (0,0)-indexed.
function M.cursor_set_keys(pos, before)
    if before then
        if pos[2] == 0 then
            pos[1] = pos[1] - 1
            -- pos2 is set to last columnt of previous line.
            -- # counts bytes, but win_set_cursor expects bytes, so all's good.
            pos[2] = #vim.api.nvim_buf_get_lines(0, pos[1], pos[1] + 1, false)[1]
        else
            pos[2] = pos[2] - 1
        end
    end

    return "<cmd>lua vim.api.nvim_win_set_cursor(0,{"
        -- +1, win_set_cursor starts at 1.
        .. pos[1] + 1
        .. ","
        -- -1 works for multibyte because of rounding, apparently.
        .. pos[2]
        .. "})"
        .. "<cr><cmd>:silent! foldopen!<cr>"
end

-- any for any mode.
-- other functions prefixed with eg. normal have to be in that mode, the
-- initial esc removes that need.
function M.any_select(b, e, opts)
    local visual_mode = opts.visual_mode and "" or "o<C-G><C-r>_"

	-- stylua: ignore
	M.replace_feedkeys(

		-- this esc -> movement sometimes leads to a slight flicker
		-- TODO: look into preventing that reliably.
		-- simple move -> <esc>v isn't possible, leaving insert moves the
		-- cursor, maybe do check for mode beforehand.
		"<esc>"
		.. M.cursor_set_keys(b)
		.. "v"
		.. (vim.o.selection == "exclusive" and
			M.cursor_set_keys(e) or
			-- set before
			M.cursor_set_keys(e, true))
		.. visual_mode )
end

return M
