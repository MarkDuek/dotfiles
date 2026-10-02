return {
    "mikavilpas/yazi.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = {
        { "nvim-lua/plenary.nvim", lazy = true },
    },
    keys = {
        {
            "<leader>e",
            "<cmd>Yazi<cr>",
            mode = { "n", "v" },
            desc = "Open yazi at current file",
        },
        {
            "<leader>E",
            "<cmd>Yazi cwd<cr>",
            desc = "Open yazi in cwd",
        },
        {
            "<C-Up>",
            "<cmd>Yazi toggle<cr>",
            desc = "Resume yazi",
        },
    },
    opts = {
        open_for_directories = false,
        floating_window_scaling_factor = 0.9,
        yazi_floating_window_border = "rounded",
        keymaps = {
            show_help = "<f1>",
        },
    },
}
