local M = {}

local config = require("hml.config")

M.options = vim.deepcopy(config)

function M.setup(opts)
    M.options = vim.tbl_deep_extend(
        "force",
        M.options,
        opts or {}
    )

    require("hml.signs").setup(M.options)
    require("hml.autocmd").setup(M.update)
end

function M.update()
    local bufnr = vim.api.nvim_get_current_buf()

    require("hml.signs").place(
        bufnr,
        require("hml.view").hml_lines()
    )
end

return M
