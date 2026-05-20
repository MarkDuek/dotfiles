return
{
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>ff", "<cmd>TodoQuickFix<cr>", desc = "TODO quickfix" },
    { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "TODO Telescope" },
  },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
}
