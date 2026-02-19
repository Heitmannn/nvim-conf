return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
        "rafamadriz/friendly-snippets",
    },
    config = function()
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())
            require("luasnip.loaders.from_vscode").lazy_load()
            require("fidget").setup({})
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls", "rust_analyzer", "gopls", "pyright", "clangd", 
                    "ts_ls", "html", "cssls", "bashls", "emmet_ls"
                },
                handlers = {
                    function(server_name) 
                        require("lspconfig")[server_name].setup {
                            capabilities = capabilities
                        }
                    end,
                    -- HTML CONFIG: Legg til htmldjango her
                    ["html"] = function()
                        require("lspconfig").html.setup {
                            capabilities = capabilities,
                            filetypes = { "html", "htmldjango" }, -- Viktig!
                            init_options = {
                                configurationSection = { "html", "css", "javascript" },
                                embeddedLanguages = {
                                    css = true,
                                    javascript = true
                                },
                                provideFormatter = true
                            }
                        }
                    end,
                    -- EMMET CONFIG: Legg til htmldjango her også
                    ["emmet_ls"] = function()
                        require("lspconfig").emmet_ls.setup {
                            capabilities = capabilities,
                            filetypes = { "html", "css", "htmldjango" },
                        }
                    end,
                    ["lua_ls"] = function()
                        require("lspconfig").lua_ls.setup {
                            capabilities = capabilities,
                            settings = {
                                Lua = {
                                    diagnostics = { globals = { "vim" } }
                                }
                            }
                        }
                    end,
                }
            })

            local luasnip = require("luasnip")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ['<S-CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<CR>'] = cmp.mapping.confirm({ select = false }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                }, {
                    { name = "buffer" },
                })
            })
            vim.diagnostic.config({
                update_in_insert = true,
                float = {
                    focusable = false,
                    style = "minimal",
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = "",
                },
                virtual_text = false, 
            })

            vim.o.signcolumn = 'yes:2'

            vim.api.nvim_create_autocmd("CursorHold", {
                buffer = bufnr,
                callback = function()
                    local opts = {
                        focusable = false,
                        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                        border = 'rounded',
                        source = 'always',
                        prefix = ' ',
                        scope = 'cursor',
                    }
                    vim.diagnostic.open_float(nil, opts)
                end
            })
        end
    }
