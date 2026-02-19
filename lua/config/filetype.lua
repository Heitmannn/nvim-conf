vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    -- Sjekk for standard pattern, pluss din spesifikke templates-mappe
    pattern = { "*.html", "*.jinja", "*.jinja2", "*.j2" },
    callback = function()
        local path = vim.fn.expand("%:p")
        -- Hvis filen ligger i en 'templates' mappe, ELLER har .jinja/.j2 extension
        if path:match("/templates/") or path:match("%.jinja") or path:match("%.j2") then
            -- 'htmldjango' er standard vim-filetype for HTML m/ template tags
            vim.bo.filetype = "htmldjango"
        end
    end,
})
