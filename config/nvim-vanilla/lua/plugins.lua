require "helpers/globals"

return {
  {
    "SidOfc/mkdx",
    config = function(_, opts)
      vim.g.markdown_folding = 1
      vim.g["mkdx#settings"] = {
        highlight = {enable = 1},
        enter = {shift = 1},
        links = {
          fragment = {complete = 1},
          external = {enable = 1},
        },
        toc = {
          text = 'Content',
          update_on_write = 0,
          position = 2,
          --details = { enable=0, nesting_level=2 },
        },
        --details = { nesting_level=-1  },
        fold = {enable = 1},
        tab = { enable = 0 },
      }
    end,
  },
  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    },
    lazy = false,
  },
  {
    "dhruvasagar/vim-table-mode",
  },
  {
    "folke/zen-mode.nvim",
    config = function()
      require "extensions.zen-mode"
    end,
    opts = {}
  },
  -- Mason
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require "extensions.mason"
    end
  },

  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.4',
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "ahmedkhalf/project.nvim",
    },
    config = function()
      require "extensions.telescope"
    end
  },

  -- CMP
  {
    'hrsh7th/nvim-cmp',
    event = "InsertEnter",
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-emoji',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-nvim-lua',
    },
    config = function()
      require "extensions.cmp"
    end,
  },

  {
    "L3MON4D3/LuaSnip",
    opts = {
      history = true,
      delete_check_events = "TextChanged",
      region_check_events = "CursorMoved",
    },
  },

  -- LSP Kind
  {
    'onsails/lspkind-nvim',
    lazy = true,
    config = function()
      require "extensions.lspkind"
    end
  },

  -- Git Signs
  {
    'lewis6991/gitsigns.nvim',
    lazy = false,
    config = function()
      require "extensions.gitsigns"
    end
  },

  -- Trouble
  {
    "folke/trouble.nvim",
    --lazy = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require "extensions.trouble"
    end,
  },

  -- TreeSitter
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require "extensions.treesitter"
    end
  },

  -- Theme: Sonokai
  {
    "sainnhe/sonokai",
    lazy = false,
    config = function ()
      require "extensions.colorscheme.sonokai"
    end
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = false,
      --light_style = "night",
    },
  },

  { "github/copilot.vim" },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {} -- this is equalent to setup({}) function
  },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
  --{ "pedrohdz/vim-yaml-folds", main = "ibl", opts = {} },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    opts = {
      filetype_exclude = { 'help', 'dashboard', 'neo-tree', 'Trouble', 'lazy', 'mason', 'markdown' },
    },

    config = function(_, opts)
      require("extensions.ufo").setup(opts)
    end,
  },

  { "dbeniamine/cheat.sh-vim", lazy = false },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
    }
  },
  -- lazy.nvim
  { "junegunn/vim-easy-align" },
  { "ludovicchabant/vim-gutentags" },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  }
}
