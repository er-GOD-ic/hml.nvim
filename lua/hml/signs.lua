local M = {}

local state = require("hml.state")

local defined = false

function M.setup()
    if defined then
        return
    end

    local opts = state.opts
    local highlights = opts.highlights
    local signs = opts.signs

    print("current highlights:", vim.inspect(highlights))

    for name, spec in pairs(highlights) do
        vim.api.nvim_set_hl(0, name, spec)
    end

    for name, spec in pairs(signs) do
        vim.fn.sign_define(name, spec)
    end

    defined = true
end

function M.place(bufnr, lines)
    M.setup()

    pcall(vim.fn.sign_unplace, "hml_marks", {
        buffer = bufnr,
    })

    local max = vim.api.nvim_buf_line_count(bufnr)

    local function place(id_offset, name, lnum)
        if not lnum or lnum < 1 or lnum > max then
            return
        end

        local id = bufnr * 100 + id_offset

        pcall(vim.fn.sign_place, id, "hml_marks", name, bufnr, {
            lnum = lnum,
        })
    end

    place(1, "HmlSignH", lines.h)
    place(2, "HmlSignM", lines.m)
    place(3, "HmlSignL", lines.l)
end

function M.reload()
    defined = false
    M.setup()
end

return M
