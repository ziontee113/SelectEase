local plenary_dir = os.getenv("PLENARY_DIR")
    or "/home/ziontee113/.local/share/nvim/lazy/plenary.nvim/"

local is_not_a_directory = vim.fn.isdirectory(plenary_dir) == 0
if is_not_a_directory then
    vim.fn.system({
        "git",
        "clone",
        "https://github.com/nvim-lua/plenary.nvim",
        plenary_dir,
    })
end

vim.opt.rtp:append(".")
vim.opt.rtp:append(plenary_dir)
require("plenary.busted")

-->

local treesitter_dir = "~/.local/share/nvim/lazy/nvim-treesitter"
vim.opt.rtp:append(treesitter_dir)

-->

vim.o.splitright = true

vim.o.tabstop = 4
vim.o.softtabstop = 0
vim.o.shiftwidth = 2
vim.o.smarttab = true
vim.o.expandtab = true

vim.o.swapfile = false
vim.bo.swapfile = false

require("nvim-treesitter.query_predicates")
