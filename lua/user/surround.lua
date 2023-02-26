local M = {}

function M.setup()
    local status_surround, surround = pcall(require, "surround")
    if not status_surround then
        return
    end

    surround.setup {
        context_offset = 100,
        load_autogroups = false,
        mappings_style = "surround",
        map_insert_mode = true,
        quotes = { "'", '"' },
        brackets = { "(", '{', '[' },
        pairs = {
            nestable = { { "(", ")" }, { "[", "]" }, { "{", "}" } },
            linear = { { "'", "'" }, { "`", "`" }, { '"', '"' } }
        },
        prefix = "s"
    }
end

return M
