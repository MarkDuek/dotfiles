return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("harpoon"):setup()
    end,
    keys = {
        {
            "<leader>a",
            function()
                require("harpoon"):list():add()
            end,
            desc = "Harpoon add file",
        },
        {
            "<C-e>",
            function()
                local harpoon = require("harpoon")
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end,
            desc = "Harpoon menu",
        },
        {
            "<C-h>",
            function()
                require("harpoon"):list():select(1)
            end,
            desc = "Harpoon file 1",
        },
        {
            "<C-j>",
            function()
                require("harpoon"):list():select(2)
            end,
            desc = "Harpoon file 2",
        },
        {
            "<C-k>",
            function()
                require("harpoon"):list():select(3)
            end,
            desc = "Harpoon file 3",
        },
        {
            "<C-l>",
            function()
                require("harpoon"):list():select(4)
            end,
            desc = "Harpoon file 4",
        },
        {
            "<leader>hp",
            function()
                require("harpoon"):list():prev()
            end,
            desc = "Previous Harpoon file",
        },
        {
            "<leader>hn",
            function()
                require("harpoon"):list():next()
            end,
            desc = "Next Harpoon file",
        },
    },
}
