-- require("ufo").setup({ })

local M = {}

function M.setup(opts)
  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('local_detach_ufo', { clear = true }),
    pattern = opts.filetype_exclude,
    callback = function()
      require('ufo').detach()
    end,
  })

    --vim.o.foldcolumn = '1' -- '0' is not bad
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
    --vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
    --vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)


  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true
  }
  local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
  for _, ls in ipairs(language_servers) do
      require('lspconfig')[ls].setup({
          capabilities = capabilities
          -- you can add other fields for setting up lsp server in this table
      })
  end
  require('ufo').setup(opts)
end

return M

