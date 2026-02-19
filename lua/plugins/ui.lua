return {
    -- 1. FILE EXPLORER (Neo-tree)
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- Krever Nerd Font
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require("neo-tree").setup({
                event_handlers = {
                    {
                        event = "file_opened",
                        handler = function(file_path)
                            -- auto close
                            require("neo-tree.command").execute({ action = "close" })
                        end
                    },
                },
                window = {
                    position = "left",
                    width = 30,
                },
                filesystem = {
                    filtered_items = {
                        visible = true, -- Vis skjulte filer (dotfiles)
                        hide_dotfiles = false,
                        hide_gitignored = false,
                    },
                },
            })
            
            -- Keymap for å åpne/lukke treet (Space + e)
            vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Toggle File Explorer" })
        end,
    },

    -- 2. STATUS BAR (Lualine)
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup({
                options = {
                    theme = 'ayu_mirage', -- Du kan endre tema her senere
                    component_separators = '|',
                    section_separators = '',
                },
            })
        end
    },

    -- 3. KEY HELPER (Which-key)
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300 -- Viser menyen etter 300ms
        end,
        opts = {
            -- Her kan du konfigurere utseendet om du vil, men defaults er bra.
        }
    },

    -- 4. AUTOPAIRS (Lukker parenteser automatisk)
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true -- Bruker default config
    }
}
