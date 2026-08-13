return {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    ft = "markdown",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    keys = {
        { "<leader>On", "<cmd>Obsidian new<cr>", desc = "Obsidian new note" },
        { "<leader>Oo", "<cmd>Obsidian quick_switch<cr>", desc = "Obsidian open note" },
        { "<leader>Os", "<cmd>Obsidian search<cr>", desc = "Obsidian search notes" },
        { "<leader>Ot", "<cmd>Obsidian today<cr>", desc = "Obsidian today's note" },
        { "<leader>Ob", "<cmd>Obsidian backlinks<cr>", desc = "Obsidian backlinks" },
    },
    opts = {
        -- Commands use the v3+ subcommand syntax: :Obsidian <command>.
        legacy_commands = false,
        workspaces = {
            {
                name = "notes",
                path = "/home/mark/Resources/mark-notes/repo",
            },
        },
    },
}
