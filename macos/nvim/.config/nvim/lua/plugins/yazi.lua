return {
    "mikavilpas/yazi.nvim",
    version = "*",
    cmd = "Yazi",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        { "<leader>e", "<cmd>Yazi<cr>", mode = { "n", "v" }, desc = "Open Yazi at current file" },
        { "<leader>E", "<cmd>Yazi cwd<cr>", desc = "Open Yazi in cwd" },
        { "<leader>fr", "<cmd>Yazi toggle<cr>", desc = "Resume Yazi" },
    },
    opts = {
        open_for_directories = false,
        keymaps = {
            -- This optional shortcut needs GNU coreutils on macOS.
            copy_relative_path_to_selected_files = false,
        },
    },
}
