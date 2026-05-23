local M = {}

function M.setup(callback)
    vim.api.nvim_create_autocmd({
        "BufEnter",
        "BufWinEnter",
        "WinScrolled",
        "CursorMoved",
        "CursorMovedI",
    }, {
        callback = callback,
    })

    vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
            require("hml.signs").reload()
        end,
    })

    local ns = vim.api.nvim_create_namespace("hml_watch")

    vim.api.nvim_set_decoration_provider(ns, {
        on_win = function(_, winid, bufnr, topline, botline)
            local prev = vim.w._hml_view

            if not prev or prev.top ~= topline or prev.bot ~= botline then
                vim.w._hml_view = {
                    top = topline,
                    bot = botline,
                }

                vim.schedule(callback)
            end
        end,
    })
end

return M
