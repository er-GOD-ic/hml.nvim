local M = {}

local defined = false

local function get_hl_fg(name, fallback)
    local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })

    if ok and hl and hl.fg then
        return string.format("#%06x", hl.fg)
    end

    return fallback
end

function M.setup()
    if defined then
        return
    end

    local color = get_hl_fg("DiagnosticHint", "#00aaff")

    vim.api.nvim_set_hl(0, "HmlNumHL_H", {
        fg = color,
        bold = true,
        default = true,
    })

    vim.api.nvim_set_hl(0, "HmlNumHL_M", {
        fg = color,
        bold = true,
        default = true,
    })

    vim.api.nvim_set_hl(0, "HmlNumHL_L", {
        fg = color,
        bold = true,
        default = true,
    })

    vim.fn.sign_define("HmlSignH", {
        text = " ",
        texthl = "",
        numhl = "HmlNumHL_H",
    })

    vim.fn.sign_define("HmlSignM", {
        text = " ",
        texthl = "",
        numhl = "HmlNumHL_M",
    })

    vim.fn.sign_define("HmlSignL", {
        text = " ",
        texthl = "",
        numhl = "HmlNumHL_L",
    })

    defined = true
end

function M.place(bufnr, lines)
    M.setup()

    pcall(vim.fn.sign_unplace, "hml_marks", { buffer = bufnr })

    local max = vim.api.nvim_buf_line_count(bufnr)

    local function place(id_offset, name, lnum)
        if not lnum or lnum < 1 or lnum > max then
            return
        end

        local id = bufnr * 100 + id_offset

        pcall(vim.fn.sign_place, id, "hml_marks", name, bufnr, { lnum = lnum })
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
