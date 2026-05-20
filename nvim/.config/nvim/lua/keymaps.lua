vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open file explorer" })

vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Write buffer" })
vim.keymap.set("n", "<leader>qq", "<cmd>q<cr>", { desc = "Quit" })

vim.keymap.set("n", "<leader>n", "<cmd>bn<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>p", "<cmd>bp<cr>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>x", "<cmd>bd<cr>", { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>ml", "<cmd>b#<cr>", { desc = "Alternate buffer" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half-page down centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half-page up centered" })

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to clipboard" })

vim.keymap.set("n", "<leader>h", "<cmd>noh<cr>", { desc = "Clear search highlight" })

vim.keymap.set("n", "]g", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set("n", "[g", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
