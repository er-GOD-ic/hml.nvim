local M = {}

local defined = false

local function is_hex(str)
    return type(str) == "string"
        and str:match("^#%x%x%x%x%x%x$")
end

local function get_hl_fg(name, fallback)
    local ok, hl = pcall(
        vim.api.nvim_get_hl,
        0,
        {
            name = name,
            link = false,
        }
    )

    if ok and hl and hl.fg then
        return string.format("#%06x", hl.fg)
    end

    return fallback
end

local function resolve_highlight(name, value)
    local hl_name = "HmlNumHL_" .. name

    -- nil fallback
    if value == nil then
        value = {
            link = "Directory",
        }
    end

    -- string
    if type(value) == "string" then
        -- #rrggbb
        if is_hex(value) then
            vim.api.nvim_set_hl(
                0,
                hl_name,
                {
                    fg = value,
                    bold = true,
                }
            )

            return hl_name
        end

        -- highlight group
        local fg = get_hl_fg(
            value,
            "#00aaff"
        )

        vim.api.nvim_set_hl(
            0,
            hl_name,
            {
                fg = fg,
                bold = true,
            }
        )

        return hl_name
    end

    -- table:
    -- directly pass to nvim_set_hl
    if type(value) == "table" then
        vim.api.nvim_set_hl(
            0,
            hl_name,
            value
        )

        return hl_name
    end

    -- fallback
    vim.api.nvim_set_hl(
        0,
        hl_name,
        {
            fg = "#00aaff",
            bold = true,
        }
    )

    return hl_name
end

function M.setup(opts)
    if defined then
        return
    end

    opts = opts or {}

    local highlights = opts.highlight or {}
    local signs = opts.signs or {}

    local hl_h = resolve_highlight(
        "H",
        highlights.h
    )

    local hl_m = resolve_highlight(
        "M",
        highlights.m
    )

    local hl_l = resolve_highlight(
        "L",
        highlights.l
    )

    vim.fn.sign_define(
        "HmlSignH",
        {
            text = signs.h or " ",
            texthl = "",
            numhl = hl_h,
        }
    )

    vim.fn.sign_define(
        "HmlSignM",
        {
            text = signs.m or " ",
            texthl = "",
            numhl = hl_m,
        }
    )

    vim.fn.sign_define(
        "HmlSignL",
        {
            text = signs.l or " ",
            texthl = "",
            numhl = hl_l,
        }
    )

    defined = true
end

function M.place(bufnr, lines)
    M.setup()

    pcall(
        vim.fn.sign_unplace,
        "hml_marks",
        {
            buffer = bufnr,
        }
    )

    local max =
        vim.api.nvim_buf_line_count(bufnr)

    local function place(id_offset, name, lnum)
        if not lnum
            or lnum < 1
            or lnum > max
        then
            return
        end

        local id = bufnr * 100 + id_offset

        pcall(
            vim.fn.sign_place,
            id,
            "hml_marks",
            name,
            bufnr,
            {
                lnum = lnum,
            }
        )
    end

    place(1, "HmlSignH", lines.h)
    place(2, "HmlSignM", lines.m)
    place(3, "HmlSignL", lines.l)
end

function M.reload(opts)
    defined = false
    M.setup(opts)
end

return M
