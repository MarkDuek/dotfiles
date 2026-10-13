return {
    "saghen/blink.cmp",
    version = "1.*",
    event = "InsertEnter",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
        keymap = {
            preset = "default",
            ["<C-Space>"] = { "select_and_accept" },
            ["<S-Tab>"] = { "snippet_backward", "fallback" },
        },
        sources = { default = { "lsp", "path", "snippets", "buffer" } },
        fuzzy = { implementation = "prefer_rust" },
        signature = { enabled = true },
    },
}
