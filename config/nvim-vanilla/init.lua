require "custom.cfn"

vim.opt.syntax = 'enable' 
vim.opt.termguicolors = true 

vim.o.spelllang = "en_us"

vim.opt.background = 'dark'

vim.opt.clipboard = 'unnamedplus' 

vim.wo.number = true 
vim.wo.relativenumber = true 

vim.wo.cursorline = true

vim.opt.showmatch = true

vim.opt.ruler = true

vim.opt.hlsearch = true 
vim.opt.incsearch = true 
vim.opt.ignorecase = true 
vim.opt.smartcase = true 

vim.opt.expandtab = true 
vim.opt.tabstop = 4 
vim.opt.shiftwidth = 4 

vim.opt.autoread = true

vim.opt.undofile = true

vim.wo.signcolumn = "no"

vim.opt.laststatus = 2 
vim.cmd [[
  highlight StatusLine cterm=none ctermfg=White ctermbg=DarkGrey
  highlight StatusLineNC cterm=none ctermfg=DarkGrey ctermbg=None
]]

vim.opt.statusline = '%f ' 
vim.opt.statusline:append('%y ') 
vim.opt.statusline:append('[%{&fileformat}] ') 
vim.opt.statusline:append('[%{&encoding}] ') 
vim.opt.statusline:append('%=') 
vim.opt.statusline:append('%l/%L ') 
vim.opt.statusline:append('col %c ') 
vim.opt.statusline:append('%p%% ') 
vim.opt.statusline:append('%m ') 

require "lazy-bootstrap"
require "settings"
require "keybindings"

local lazy = require("lazy")
lazy.setup("plugins")

vim.cmd "command! -range=% -nargs=0 Run lua require('custom.cfn').runit(<line1>, <line2>)"
vim.cmd "command! -range=% -nargs=0 Calc lua require('custom.cfn').calcit(<line1>, <line2>)"
vim.cmd "command! -range=% -nargs=0 Beauty lua require('custom.cfn').beautify_bash_command(<line1>, <line2>)"
vim.cmd "command! -range=% -nargs=0 RunBuffer lua require('custom.cfn').run_command_buffer(<line1>, <line2>)"
vim.cmd "command! -range=% -nargs=0 Gpt lua require('custom.cfn').chatgpt(<line1>, <line2>)"

vim.cmd "command! -range=% -nargs=0 Zhistsearchs lua require('telescope.builtin').search_history()<CR>"
vim.cmd "command! -range=% -nargs=0 Zhistcommands lua require('telescope.builtin').command_history()<CR>"
vim.cmd "command! -range=% -nargs=0 Zmarks lua require('telescope.builtin').marks()<CR>"
vim.cmd("command! -nargs=0 Zfunz lua require('custom.cfn').list_functions()")

vim.cmd "command! -range=% -nargs=0 PASTE lua require('custom.cfn').runit_fixed('xclip -selection clipboard -o')"
vim.api.nvim_set_keymap('n', '<Leader>vs', [[<Cmd>let @z=&so<CR>:set so=0 noscb<CR>:bo vs<CR>Ljzt:setl scb<CR><C-w>p:setl scb<CR>:let &so=@z<CR>]], { noremap = true, silent = true })

vim.api.nvim_set_keymap('i', '<C-s>', '<Esc>:w<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', {noremap = true})
