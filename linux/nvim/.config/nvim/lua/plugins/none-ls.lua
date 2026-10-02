return {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvimtools/none-ls-extras.nvim", "jayp0521/mason-null-ls.nvim" },
    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                require("none-ls.formatting.ruff").with({ extra_args = { "--extend-select", "I" } }),
                require("none-ls.formatting.ruff_format"),
            },
        })

    end,
}
