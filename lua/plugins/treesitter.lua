return {
    {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.config")

        configs.setup({
            -- Sørg for at 'jinja2' og 'html' er med her
            ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python", "go", "bash", "html", "css", "javascript", "jinja2", "markdown" },
            sync_install = false,
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
        })

        -- VIKTIG: Dette kobler htmldjango-filtypen til html-parseren
        vim.treesitter.language.register("html", "htmldjango")
    end
},
{
    "MeanderingProgrammer/treesitter-modules.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<CR>",
                node_incremental = "<CR>",
                node_decremental = "<S-CR>",
            },
        },
    },
}
}
