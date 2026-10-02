return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            local function get_python_path()
                local handle = io.popen("pyenv which python")
                if handle then
                    local result = handle:read("*a")
                    handle:close()
                    return result and result:gsub("%s+", "")
                end
                return nil
            end

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("lsp_keymaps", { clear = true }),
                callback = function(args)
                    local opts = { buffer = args.buf, silent = true }

                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
                    vim.keymap.set("n", "grn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
                    vim.keymap.set({ "n", "x" }, "gra", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
                    vim.keymap.set("n", "grr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "References" }))
                    vim.keymap.set("n", "gri", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Implementation" }))
                    vim.keymap.set("n", "gO", vim.lsp.buf.document_symbol, vim.tbl_extend("force", opts, { desc = "Document symbols" }))
                    vim.keymap.set("n", "gld", function()
                        vim.lsp.buf.format({ async = true })
                    end, vim.tbl_extend("force", opts, { desc = "Format buffer" }))
                    vim.keymap.set("i", "<C-S>", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Signature help" }))
                end,
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if client and client.name == "ruff" then
                        client.server_capabilities.hoverProvider = false
                    end
                end,
                desc = "Disable Ruff hover in favor of Pyright",
            })

            vim.lsp.config("lua_ls", {})

            vim.lsp.config("pyright", {
                before_init = function(_, config)
                    config.settings = config.settings or {}
                    config.settings.python = config.settings.python or {}
                    config.settings.python.pythonPath = get_python_path()
                end,
            })

            vim.lsp.config("ruff", {})
            vim.lsp.config("clangd", {})

            vim.lsp.enable({ "lua_ls", "pyright", "ruff", "clangd" })
        end,
    }
}
