return {
  {
    "dhruvasagar/vim-table-mode",
    enabled = false,
    init = function()
      vim.g.table_mode_map_prefix = "<localleader>t"
    end,
  },

  {
    "nvim-pack/nvim-spectre",
    enabled = false,
    keys = {
      {
        "<leader>sr",
        function()
          require("spectre").open_file_search()
        end,
        desc = "Search and replace in current file",
      },
      {
        "<leader>sR",
        function()
          require("spectre").open()
        end,
        desc = "Search and replace",
      },
    },
  },

  {
    "rafcamlet/nvim-luapad",
    enabled = false,
    cmd = "Luapad",
    opts = {
      count_limit = 200000,
    },
  },

  {
    "tpope/vim-jdaddy",
    enabled = false,
    ft = "json",
  },

  {
    "tommcdo/vim-lion",
    enabled = false,
    init = function()
      vim.g.lion_squeeze_spaces = 1
      vim.g.lion_map_right = "ga"
      vim.g.lion_map_left = "gA"
    end,
  },

  {
    "tpope/vim-obsession",
    enabled = false,
    cmd = "Obsession",
  },

  {
    "hanschen/vim-ipython-cell",
    enabled = false,
    dependencies = "vim-slime",
    ft = "python",
    keys = {
      { "<c-c><c-f>", "IPythonCellRun", desc = "Run current file" },
      { "<c-c><c-t>", "IPythonCellRunTime", desc = "Run and time current file" },
      {
        "<c-c><c-x>",
        "IPythonCellExecuteCellVerbose",
        desc = "Print and execute current cell",
      },
      {
        "<c-c><c-j>",
        "IPythonCellExecuteCellVerboseJump",
        desc = "Print and execute current cell",
      },
      { "<c-c><c-l>", "IPythonCellClear", desc = "Clear IPython screen" },
      { "[C", "IPythonCellPrevCell", desc = "Go to previous cell header" },
      { "]C", "IPythonCellNextCell", desc = "Go to next cell header" },
    },
    init = function()
      vim.g.ipython_cell_delimit_cells_by = "tags"
    end,
  },

  {
    "jupyter-vim/jupyter-vim",
    enabled = false,
    ft = "python",
    keys = {
      { "<localleader>R", "<cmd>JupyterRunFile<cr>", desc = "Run file" },
      { "<localleader>I", "<cmd>PythonImportThisFile<cr>", desc = "Import file" },
      { "<localleader>X", "<cmd>JupyterSendCell<cr>", desc = "Send cell" },
      { "<localleader>E", "<cmd>JupyterSendRange<cr>", desc = "Send range" },
      { "<localleader>e", "<Plug>JupyterRunTextObj", desc = "Run text object" },
      { "<localleader>e", "<Plug>JupyterRunVisual", desc = "Run selection" },
    },
    init = function()
      vim.g.jupyter_mapkeys = 1
    end,
  },
}
