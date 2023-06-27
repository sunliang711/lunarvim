local M = {}

function M.setup()
    local status_comments, comments = pcall(require, "todo-comments")
    if not status_comments then
        return
    end

    comments.setup()
end

return M
