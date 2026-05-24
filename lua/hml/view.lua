local M = {}

function M.hml_lines()
    local h_line = vim.fn.line("w0") == 1 and 1 or vim.fn.line("w0") + vim.o.scrolloff
    local m_line = math.floor((vim.fn.line("w0") + vim.fn.line("w$")) / 2)
    if m_line < h_line then
        m_line = h_line
    end
    local l_line = vim.fn.line("w$") == vim.fn.line("$") and vim.fn.line("$") or vim.fn.line("w$") - vim.o.scrolloff

    return {
        h = h_line,
        m = m_line,
        l = l_line,
    }
end

return M
