local M = {}

local defaults = require("hml.config")
local state = require("hml.state")

local function merge_highlights(defaults, user)
    return vim.tbl_extend("force", defaults, user or {})
end

function M.setup(opts)
    opts = opts or {}

    state.opts = vim.tbl_deep_extend("force", defaults, opts)

    -- highlights is replace semantics
    state.opts.highlights = merge_highlights(defaults.highlights, opts.highlights)

    require("hml.signs").setup()
    require("hml.autocmd").setup(M.update)
end

function M.update()
    local bufnr = vim.api.nvim_get_current_buf()

    require("hml.signs").place(bufnr, require("hml.view").hml_lines())
end

return M
