return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require("nvim-treesitter").setup({
                ensure_installed = {
                    "vimdoc",
                    "javascript",
                    "typescript",
                    "c",
                    "lua",
                    "rust",
                    "jsdoc",
                    "bash",
                    "go",
                    "html",
                    "css",
                    "tsx",
                },

                sync_install = false,
                auto_install = true,

                indent = { enable = true },

                hightlight = { enable = true },
            })
        end,
    }
}
