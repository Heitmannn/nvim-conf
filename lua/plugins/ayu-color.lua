return {
    {
        "Shatur/neovim-ayu",
        lazy = false,    -- IKKE vent. Last nå.
        priority = 1000, -- Last først av alt.
        config = function()
             -- Konfigurer valgfrie ting (valgfritt)
            require("ayu").setup({ mirage = false })
            
            -- Faktisk aktivere fargen (Påkrevd)
            vim.cmd("colorscheme ayu")
        end,
    }
}
