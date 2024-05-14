local notify = require("notify")

notify.setup({
    timeout = 3000,
    render = "compact",
    stages = "fade",
    top_down = false,
})

--vim.notify = notify
