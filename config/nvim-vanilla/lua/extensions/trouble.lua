--[[
  File: trouble.lua
  Description: Configuration of trouble.nvim
  See: https://github.com/folke/trouble.nvim
]]

local trouble = require("trouble")

trouble.setup({
    icons = true,
    fold_open = "v", -- icon used for open folds
    fold_closed = ">", -- icon used for closed folds
    indent_lines = false, -- add an indent guide below the fold icons
    signs = {
      -- icons / text used for a diagnostic
      error = "",
      warning = "",
      hint = "",
      information = "",
      other = "",
    },
    use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
})
