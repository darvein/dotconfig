require "helpers/globals"
require "helpers/keyboard"

g.mapleader = ' '                                                                 -- Use Space, like key for alternative hotkeys

nm('K', '<cmd>lua vim.lsp.buf.hover()<CR>' )                                      -- Hover object
nm('ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')                                -- Code actions
nm('gR', '<cmd>lua vim.lsp.buf.rename()<CR>')                                     -- Rename an object
nm('gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')                                -- Go to declaration

nm('gd', '<cmd>Telescope lsp_definitions<CR>')                            -- Goto declaration
nm('<leader>p', '<cmd>Telescope oldfiles<CR>')                                   -- Show recent files
nm('<leader>O', '<cmd>Telescope git_files<CR>')                                  -- Search for a file in project
nm('<leader>f', '<cmd>Telescope find_files<CR>')                                 -- Search for a file (ignoring git-ignore)
--nm('<leader>i', '<cmd>Telescope jumplist<CR>')                                   -- Show jumplist (previous locations)
nm('<leader>w', '<cmd>Telescope live_grep<CR>')                                  -- Find a string in project
nm('<leader>b', '<cmd>Telescope buffers<CR>')                                    -- Show all buffers
nm('<leader>a', '<cmd>Telescope<CR>')                                            -- Show all commands
nm('<leader>t', '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>')

nm('<leader>x', '<cmd>TroubleToggle<CR>')                                         -- Show all problems in project (with help of LSP)
nm('gr', '<cmd>Trouble lsp_references<CR>')                                       -- Show use of object in project


--nm('<leader>ee', "<cmd>lua require('telescope.builtin').search_history()<CR>")
--vim.api.nvim_set_keymap('n', '<leader>ee', "<cmd>lua require('telescope.builtin').search_history()<CR>", { noremap = true, silent = true })

-- vim:tabstop=2 shiftwidth=2 expandtab syntax=lua foldmethod=marker foldlevelstart=0 foldlevel=0




-- Map the custom function to <leader>f
