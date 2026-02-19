return {
        'nvim-telescope/telescope.nvim', version = '*',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        },
        config = function()
        local builtin = require('telescope.builtin')
            vim.keymap.set({'n', 'v'}, '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
            vim.keymap.set({'n', 'v'}, '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
            vim.keymap.set({'n', 'v'}, '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
            vim.keymap.set({'n', 'v'}, '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
        end
}
