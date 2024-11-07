local get_icon = require("astroui").get_icon
return {
    "neo-tree.nvim",
    opts = {
        close_if_last_window = true,
        sources = { "filesystem" },
        source_selector = {
            winbar = false,
            sources = {
                { source = "filesystem", display_name = get_icon("FolderClosed", 1, true) .. "File" }, -- 根据文件显示项目名称
                -- { source = "buffers", display_name = get_icon("DefaultFile", 1, true) .. "Bufs" },
                -- { source = "git_status", display_name = get_icon("Git", 1, true) .. "Git" },
                -- { source = "remote", display_name = get_icon("Session", 1, true) .. "Remote" },
            },
            statusline = true,
        },
    },
}
