local opt = vim.opt

opt.guicursor = "" -- Bruk blokk-cursor
opt.nu = true      -- Vis linjenummer
opt.relativenumber = true -- Vis relative linjenummer (gjør det lett å hoppe '10j')

opt.tabstop = 4       -- Tabulator bredde
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true  -- Bruk spaces istedenfor tabs

opt.smartindent = true -- Automatisk innrykk

opt.wrap = false -- Slå av linjebryting som standard (kode er ofte bred)

opt.swapfile = false -- Ingen swap filer
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true  -- Persistent undo (kan angre selv etter du har lukket filen)

opt.hlsearch = false -- Fjern highlighting etter søk er ferdig
opt.incsearch = true -- Vis søk mens du skriver

opt.scrolloff = 8    -- Behold alltid 8 linjer over/under markøren (smooth scrolling)
opt.updatetime = 50  -- Raskere responstid
