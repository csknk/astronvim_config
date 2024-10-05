-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing
---@type LazySpec
return {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
        -- Configure core features of AstroNvim
        features = {
            large_buf = {size = 1024 * 256, lines = 10000}, -- set global limits for large files for disabling features like treesitter
            autopairs = true, -- enable autopairs at start
            cmp = true, -- enable completion at start
            diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
            highlighturl = true, -- highlight URLs at start
            notifications = true -- enable notifications at start
        },
        -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
        diagnostics = {virtual_text = true, underline = true},
        -- vim options can be configured here
        options = {
            opt = { -- vim.opt.<key>
                relativenumber = false, -- sets vim.opt.relativenumber
                number = true, -- sets vim.opt.number
                spell = false, -- sets vim.opt.spell
                signcolumn = "yes", -- sets vim.opt.signcolumn to yes
                wrap = false -- sets vim.opt.wrap
            },
            g = { -- vim.g.<key>
                markdown_fenced_languages = {
                    "bash", "python", "sh", "go", "rust", "c", "cpp", "lua",
                    "json"
                }
                -- configure global vim variables (vim.g)
                -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
                -- This can be found in the `lua/lazy_setup.lua` file
            }
        },
        -- Mappings can be configured through AstroCore as well.
        -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
        mappings = {
            -- first key is the mode
            i = {["jk"] = {"<Esc>"}},
            n = {
                -- second key is the lefthand side of the map

                -- navigate buffer tabs
                ["]b"] = {
                    function()
                        require("astrocore.buffer").nav(vim.v.count1)
                    end,
                    desc = "Next buffer"
                },
                ["[b"] = {
                    function()
                        require("astrocore.buffer").nav(-vim.v.count1)
                    end,
                    desc = "Previous buffer"
                },
                -- echo filepath
                ["<leader>fp"] = {
                    "<cmd>echo expand('%:p')<cr>",
                    desc = "Get filepath"
                },

                -- mappings seen under group name "Buffer"
                ["<leader>bn"] = {"<cmd>tabnew<cr>", desc = "New tab"},
                ["<Leader>bd"] = {
                    function()
                        require("astroui.status.heirline").buffer_picker(
                            function(bufnr)
                                require("astrocore.buffer").close(bufnr)
                            end)
                    end,
                    desc = "Close buffer from tabline"
                }

                -- tables with just a `desc` key will be registered with which-key if it's installed
                -- this is useful for naming menus
                -- ["<Leader>b"] = { desc = "Buffers" },

                -- setting a mapping to false will disable it
                -- ["<C-S>"] = false,
            }
        },
        autocmds = {
            templates = {
                {
                    event = "BufNewFile",
                    pattern = "*.sh",
                    group = "templates",
                    callback = function(args)
                        if not vim.b[args.buf].skeleton_added then
                            vim.cmd(string.format("0put =readfile('%s')",
                                                  "/home/david/.config/nvim/skeleton/bash.sh")) -- Insert template contents
                            vim.api.nvim_command("normal! G") -- Jump to the end of the document
                            vim.api.nvim_feedkeys("o", "n", true) -- Add line & switch to insert mode
                            vim.b[args.buf].skeleton_added = true
                        end
                    end,
                    desc = "Load shell file template"
                }
            }
        }
    }
}
