return {
    "nvim-telescope/telescope.nvim",
    tag = "v0.2.1",
    cmd = "Telescope",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
        { "<C-f>", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
        { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
        { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
        { "<leader>dt", "<cmd>Telescope colorscheme<cr>", desc = "Colorschemes" },
        { "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Marks" },
    },
    opts = {
        pickers = {
            find_files = {
                find_command = { "fd", "--type", "f", "--hidden", "--exclude", ".git" },
            },
        },
    },
}
