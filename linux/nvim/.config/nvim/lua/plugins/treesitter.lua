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

        -- Neovim 0.12's markdown runtime parser does not work correctly with
        -- nvim-treesitter's set-lang-from-info-string! injection directive.
        vim.treesitter.query.set("markdown", "injections", [[
(fenced_code_block
  (info_string
    (language) @injection.language)
  (code_fence_content) @injection.content)

((html_block) @injection.content
  (#set! injection.language "html")
  (#set! injection.combined)
  (#set! injection.include-children))

((minus_metadata) @injection.content
  (#set! injection.language "yaml")
  (#offset! @injection.content 1 0 -1 0)
  (#set! injection.include-children))

((plus_metadata) @injection.content
  (#set! injection.language "toml")
  (#offset! @injection.content 1 0 -1 0)
  (#set! injection.include-children))

([
  (inline)
  (pipe_table_cell)
] @injection.content
  (#set! injection.language "markdown_inline"))
]])
    end,
}
