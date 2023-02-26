local M = {}

function M.setup()
    local status, saga = pcall(require, 'lspsaga')
    if not status then
        return
    end

    saga.setup()
end

return M
