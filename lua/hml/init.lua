local M = {}

local signs = require("hml.signs")
local autocmd = require("hml.autocmd")
local view = require("hml.view")

function M.update()
    local bufnr = vim.api.nvim_get_current_buf()

    signs.place(bufnr, view.hml_lines())
end

function M.setup(opts)
    signs.setup()
    autocmd.setup(M.update)
end

return M
