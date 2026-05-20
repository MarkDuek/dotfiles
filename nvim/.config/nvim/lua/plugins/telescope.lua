return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "folke/todo-comments.nvim",
    },
    keys = {
        {
            "<C-p>",
            function()
                require("telescope.builtin").find_files()
            end,
            desc = "Find files",
        },
        {
            "<C-f>",
            function()
                require("telescope.builtin").live_grep()
            end,
            desc = "Live grep",
        },
        {
            "<C-s>",
            function()
                require("telescope.builtin").lsp_document_symbols()
            end,
            desc = "Document symbols",
        },
        {
            "<leader>fh",
            function()
                require("telescope.builtin").help_tags()
            end,
            desc = "Help tags",
        },
        {
            "<leader>fb",
            function()
                require("telescope.builtin").buffers()
            end,
            desc = "Buffers",
        },
        {
            "<leader>dt",
            function()
                require("telescope.builtin").colorscheme()
            end,
            desc = "Colorschemes",
        },
        {
            "<leader>fm",
            function()
                require("telescope.builtin").marks()
            end,
            desc = "Marks",
        },
    },
}
