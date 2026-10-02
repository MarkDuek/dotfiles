vim.diagnostic.config({ virtual_text = true })

vim.api.nvim_create_user_command("DiagnosticsToggleVirtualText", function()
    local virtual_text = vim.diagnostic.config().virtual_text
    vim.diagnostic.config({ virtual_text = not virtual_text })
end, {})

vim.api.nvim_create_user_command("DiagnosticsToggle", function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, {})
