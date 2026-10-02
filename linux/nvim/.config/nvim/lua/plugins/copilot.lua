return {
    "github/copilot.vim",
    init = function()
        vim.g.copilot_no_tab_map = true
    end,
    config = function()
        vim.keymap.set("i", "<Tab>", 'copilot#Accept("<CR>")', {
            expr = true,
            silent = true,
            replace_keycodes = false,
            desc = "Accept Copilot suggestion",
        })
    end,
}
