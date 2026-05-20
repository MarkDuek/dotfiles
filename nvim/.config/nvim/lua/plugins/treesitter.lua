return
{
    "nvim-treesitter/nvim-treesitter",
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })()
    end,
    opts = {
        parser_install_dir = vim.fn.stdpath("cache") .. "/treesitter",
        ensure_installed = {
            "bash",
            "c",
            "cpp",
            "lua",
            "markdown",
            "markdown_inline",
            "python",
            "vim",
            "vimdoc",
        },
        highlight = {
            enable = true,
        },
        indent = {
            enable = true,
        },
    },
    config = function(_, opts)
        vim.opt.runtimepath:prepend(opts.parser_install_dir)
        require("nvim-treesitter.configs").setup(opts)
    end,
}
