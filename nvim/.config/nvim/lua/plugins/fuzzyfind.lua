return {
  {
    "ibhagwan/fzf-lua",
    dependencies = {
      { "junegunn/fzf", build = "./install --bin" },
    },
    cmd = "FzfLua",
    keys = {
      { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Find buffers" },
      {
        "<leader>fm",
        "<cmd>FzfLua oldfiles<cr>",
        desc = "Find most recently used files",
      },
      { "<leader>fk", "<cmd>FzfLua keymaps<cr>", desc = "Find keymaps" },
      {
        "<leader>fs",
        function()
          local fzf_lua = require("fzf-lua")
          return fzf_lua.lsp_document_symbols() or fzf_lua.treesitter()
        end,
        desc = "Find symbols",
      },
      {
        "<leader>fS",
        "<cmd>FzfLua lsp_live_workspace_symbols<cr>",
        desc = "Find workspace symbols",
      },
      {
        "<leader>fc",
        "<cmd>FzfLua git_bcommits<cr>",
        desc = "Find git commits (file)",
      },
      {
        "<leader>fC",
        "<cmd>FzfLua git_commits<cr>",
        desc = "Find git commits (repo)",
      },
      { "<leader>fg", "<cmd>FzfLua git_status<cr>", desc = "Find changed files" },
      { "<leader>fu", "<cmd>FzfLua ultisnips<cr>", desc = "Find snippets" },
      {
        "<leader>fl",
        "<cmd>FzfLua resume<cr>",
        desc = "Resume last fuzzy search",
      },
      {
        "<leader>fq",
        "<cmd>FzfLua quickfix<cr>",
        desc = "List items in the quickfix list",
      },
      { "<leader>ft", "<cmd>TodoFzfLua<cr>", desc = "Find todos" },
      {
        "<leader>f/",
        "<cmd>FzfLua current_buffer_fuzzy_find<cr>",
        desc = "Live fuzzy search inside of the currently open buffer",
      },
      { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find files" },
      { "<leader>fr", "<cmd>FzfLua live_grep<cr>", desc = "Live grep" },
    },
    config = function()
      require("fzf-lua").setup({
        "telescope",
        winopts = {
          preview = {
            horizontal = "right:60%",
          },
        },
        previewers = {
          builtin = {
            -- Disable syntax highlighting for files bigger than 100KB
            syntax_limit_b = 1024 * 100,
          },
        },
        oldfiles = {
          include_current_session = true,
        },
        grep = {
          rg_opts = "--column "
            .. "--line-number "
            .. "--no-heading "
            .. "--color=always "
            .. "--smart-case "
            .. "--hidden "
            .. "--ignore "
            .. "--max-columns=4096 "
            .. "--glob='!{.git,.direnv,node_modules}/*' "
            .. "-e",
        },
      })
    end,
  },
}
