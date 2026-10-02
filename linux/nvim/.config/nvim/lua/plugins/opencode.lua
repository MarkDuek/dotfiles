return {
	"nickjvandyke/opencode.nvim",
	version = "*",
	config = function()
		---@type opencode.Opts
		vim.g.opencode_opts = {
			server = {
				start = false,
			},
		}

		vim.keymap.set({ "n", "x" }, "<leader>ca", function()
			require("opencode").ask("@this: ")
		end, { desc = "Ask OpenCode" })

		vim.keymap.set({ "n", "x" }, "<leader>cs", function()
			require("opencode").select()
		end, { desc = "Select OpenCode" })

		vim.keymap.set({ "n", "x" }, "go", function()
			return require("opencode").operator("@this: ...")
		end, { desc = "Ask OpenCode about range", expr = true })

		vim.keymap.set("n", "goo", function()
			return require("opencode").operator("@this: ...") .. "_"
		end, { desc = "Ask OpenCode about line", expr = true })

		vim.keymap.set("n", "<S-C-u>", function()
			require("opencode").command("session.half.page.up")
		end, { desc = "Scroll OpenCode up" })

		vim.keymap.set("n", "<S-C-d>", function()
			require("opencode").command("session.half.page.down")
		end, { desc = "Scroll OpenCode down" })
	end,
}
