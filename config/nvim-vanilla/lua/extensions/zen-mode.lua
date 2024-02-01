require("zen-mode").setup({
  wezterm = {
    hide_tab_bar_if_only_one_tab = true,
    hide_tab_bar = true,
  },
  window = {
    backdrop = 1,
    width = 120,
    height = 1,
    options = {
      signcolumn = "no",
      number = false,
      relativenumber = false,
      cursorline = false,
      cursorcolumn = false,
      foldcolumn = "0",
      list = false,
    },
  },
  on_open = function(win)
  end,
  on_close = function()
  end,
})
