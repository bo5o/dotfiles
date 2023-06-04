return {
  -- wait for https://github.com/nvim-treesitter/nvim-treesitter/issues/81
  {
    "wookayin/semshi",
    ft = "python",
    init = function()
      vim.g["semshi#error_sign"] = false
    end,
    config = function()
      vim.api.nvim_command([[silent UpdateRemotePlugins]])
    end,
  },
  { "Vimjas/vim-python-pep8-indent", ft = "python" },
  { "raimon49/requirements.txt.vim" },
  { "tridactyl/vim-tridactyl", ft = "tridactyl" },
  { "Glench/Vim-Jinja2-Syntax", ft = { "jinja", "jinja.html", "jinja.sql" } },
  { "kovetskiy/sxhkd-vim", ft = "sxhkd" },
  { "ericpruitt/tmux.vim", ft = "tmux" },
  { "fladson/vim-kitty" },
  { "ekalinin/Dockerfile.vim", ft = "Dockerfile" },
  { "chr4/nginx.vim", ft = "nginx" },
  { "jidn/vim-dbml", ft = "dbml" },
  { "NoahTheDuke/vim-just", ft = "just" },
}
