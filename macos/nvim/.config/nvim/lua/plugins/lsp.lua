return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "saghen/blink.cmp" },
    config = function()
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("lsp_keymaps", { clear = true }),
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client and client.name == "ruff" then
                    client.server_capabilities.hoverProvider = false
                end

                local function map(key, action, description)
                    vim.keymap.set("n", key, action, { buffer = args.buf, desc = description })
                end
                map("gd", vim.lsp.buf.definition, "Go to definition")
                map("gld", function()
                    vim.lsp.buf.format({ async = true, name = "ruff" })
                end, "Format buffer with Ruff")
                map("<leader>oi", function()
                    vim.lsp.buf.code_action({
                        context = { only = { "source.organizeImports" } },
                        apply = true,
                    })
                end, "Organize imports")
                map("<C-s>", "<cmd>Telescope lsp_document_symbols<cr>", "Document symbols")
            end,
        })

        vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities() })
        vim.lsp.config("basedpyright", {
            before_init = function(_, config)
                local candidates = {
                    config.root_dir and (config.root_dir .. "/.venv/bin/python") or "",
                    vim.env.VIRTUAL_ENV and (vim.env.VIRTUAL_ENV .. "/bin/python") or "",
                    vim.fn.exepath("python3.13"),
                }
                for _, python in ipairs(candidates) do
                    if python ~= "" and vim.fn.executable(python) == 1 then
                        config.settings.python = vim.tbl_extend("force", config.settings.python or {}, {
                            pythonPath = python,
                        })
                        break
                    end
                end
            end,
            settings = {
                basedpyright = {
                    disableOrganizeImports = true,
                    analysis = {
                        typeCheckingMode = "standard",
                        diagnosticSeverityOverrides = { reportUnusedImport = "none" },
                    },
                },
            },
        })
        vim.lsp.config("ruff", {})
        vim.lsp.enable({ "basedpyright", "ruff" })
    end,
}
