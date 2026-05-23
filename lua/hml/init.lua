local M = {}

local defaults = require("hml.config")
local state = require("hml.state")

function M.setup(opts)
    state.opts = vim.tbl_deep_extend(
        "force",
        defaults,
        opts or {}
    )

    require("hml.signs").setup()
	require("hml.autocmd").setup(M.update)
end

function M.update()
	local bufnr = vim.api.nvim_get_current_buf()

	require("hml.signs").place(bufnr, require("hml.view").hml_lines())
end

return M
