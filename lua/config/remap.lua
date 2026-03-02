-- Setter leader til space
vim.g.mapleader = " "

local keymap = vim.keymap.set
keymap({ "i" }, "jj", "<Esc>")

-- jump hard left og right. slutten og staren av linja.
keymap({ "n", "v", "o" }, "H", "^")
keymap({ "n", "v", "o" }, "L", "$")

-- Flytter linjer opp og ned med J og K
keymap({ "n", "v", "o" }, "J", ":m '>+1<CR>gv=gv")
keymap({ "v", "o" }, "K", ":m '<-2<CR>gv=gv")


-- Rask lagring med Space + w
keymap("n", "<leader>w", ":w<CR>")
-- Rask exit med Space + q
keymap("n", "<leader>q", ":q<CR>")

--special paste
keymap("x", "<leader>p", [["_dP]])

--sentrer søkeresultat ved søk
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

--Disable sideveis scroll
vim.keymap.set({ 'n', 'i', 'v' }, '<ScrollWheelLeft>', '<Nop>')
vim.keymap.set({ 'n', 'i', 'v' }, '<ScrollWheelRight>', '<Nop>')

-- LSP Keymaps (Disse fungerer kun når en LSP er tilkoblet)
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Hjelpefunksjon for å spare litt tekst
        local opts = { buffer = ev.buf }

        -- Gå til definisjon (Hvor er funksjonen laget?)
        keymap('n', 'gd', vim.lsp.buf.definition, opts)

        -- Se info om funksjonen/variabelen under markøren (Hover)
        -- Dette viser dokumentasjon i et litte vindu!
        -- keymap('n', 'K', vim.lsp.buf.hover, opts)

        -- Se referanser (Hvor brukes denne funksjonen?)
        keymap('n', 'gr', require('telescope.builtin').lsp_references, opts)

        -- Gi nytt navn (Rename variable i hele prosjektet)
        keymap('n', '<leader>rn', vim.lsp.buf.rename, opts)

        -- Se feilmeldingen i en flytende boks (hvis den er kuttet av i margen)
        --keymap('n', '<leader>e', vim.diagnostic.open_float, opts)

        -- Gå til forrige/neste feil
        --keymap('n', '[d', vim.diagnostic.goto_prev, opts)
        --keymap('n', ']d', vim.diagnostic.goto_next, opts)

        -- Formatere koden (Prettier/ClangFormat/Gofmt)
        keymap('n', '<leader>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})
