---List git worktrees
---@return string[] | nil
local list_worktrees = function()
  local obj = vim.system({ "git", "worktree", "list" }, { text = true }):wait()
  local code, output = obj.code, obj.stdout
  if code ~= 0 or not output then
    return nil
  end
  return vim.fn.split(output, "\n")
end

---Open a diff against the same file in another git worktree
---@param file string File path
---@param worktree string Worktree path
local diff_worktree = function(file, worktree)
  local Path = require("plenary.path")
  local root = vim.fs.root(0, ".git")
  if not root then
    return
  end
  local target = Path:new(worktree) / Path:new(file):make_relative(root)
  vim.cmd("diffsplit " .. target:absolute())
end

return {
  {
    "ibhagwan/fzf-lua",
    dependencies = {
      { "junegunn/fzf", build = "./install --bin" },
      { "ahmedkhalf/project.nvim" },
    },
    cmd = "FzfLua",
    keys = {
      {
        "<leader>fb",
        function()
          return require("fzf-lua").buffers({
            formatter = { "path.filename_first", 2 },
          })
        end,
        desc = "Find buffers",
      },
      {
        "<leader>fm",
        "<cmd>FzfLua oldfiles<cr>",
        desc = "Find most recently used files",
      },
      { "<leader>fk", "<cmd>FzfLua keymaps<cr>", desc = "Find keymaps" },
      {
        "<leader>fs",
        function()
          local fzf = require("fzf-lua")
          return fzf.lsp_document_symbols() or fzf.treesitter()
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
        "<cmd>FzfLua lgrep_curbuf<cr>",
        desc = "Live fuzzy search inside of the currently open buffer",
      },
      {
        "<leader>ff",
        function()
          local fzf = require("fzf-lua")
          local cwd = require("project_nvim.project").get_project_root()
            or vim.fs.getcwd()
          local opts = { cwd = cwd, formatter = { "path.filename_first", 2 } }
          return fzf.files(opts)
        end,
        desc = "Find files",
      },
      {
        "<leader>fp",
        function()
          local opts = { cwd = "~/projects", formatter = { "path.filename_first", 2 } }
          return require("fzf-lua").files(opts)
        end,
        desc = "Find files in all projects",
      },
      { "<leader>fr", "<cmd>FzfLua live_grep<cr>", desc = "Live grep" },
      {
        "<leader>fw",
        function()
          local paths = list_worktrees()
          if not paths then
            return
          end
          vim.ui.select(paths, { prompt = "Choose a worktree:" }, function(choice)
            local worktree = vim.fn.split(choice)[1]
            local file = vim.api.nvim_buf_get_name(0)
            diff_worktree(file, worktree)
          end)
        end,
        desc = "Find current file in another worktree and open it in diff mode",
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          ---@diagnostic disable-next-line: duplicate-set-field
          vim.ui.select = function(...)
            require("lazy").load({ plugins = { "fzf-lua" } })
            require("fzf-lua").register_ui_select()
            return vim.ui.select(...)
          end
        end,
      })
    end,
    opts = function()
      local actions = require("fzf-lua.actions")
      local file_sel_to_trouble = function(selected, opts)
        opts = vim.tbl_deep_extend("keep", opts, { copen = false })
        actions.file_sel_to_qf(selected, opts)
        vim.cmd([[Trouble qflist open]])
      end
      return {
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
          cwd_only = true,
          stat_file = true,
          include_current_session = true,
        },
        files = {
          actions = {
            ["ctrl-g"] = false,
            ["ctrl-i"] = { actions.toggle_ignore },
            ["ctrl-h"] = { actions.toggle_hidden },
          },
        },
        grep = {
          actions = {
            ["ctrl-i"] = { actions.toggle_ignore },
            ["ctrl-h"] = { actions.toggle_hidden },
            ["ctrl-q"] = { fn = file_sel_to_trouble, prefix = "select-all+" },
          },
        },
      }
    end,
  },

  {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    keys = {
      {
        "<leader>sr",
        function()
          require("grug-far").open({
            transient = true,
            prefills = { paths = vim.fn.expand("%") },
          })
        end,
        mode = "n",
        desc = "Search and replace in current file",
      },
      {
        "<leader>sr",
        function()
          require("grug-far").with_visual_selection({
            transient = true,
            prefills = { paths = vim.fn.expand("%") },
          })
        end,
        mode = "v",
        desc = "Search and replace in current file",
      },
      { "<leader>sR", "<cmd>GrugFar<cr>", desc = "Search and replace" },
      {
        "<leader>ssr",
        function()
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          require("grug-far").open({
            engine = "astgrep",
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          })
        end,
        mode = { "n", "v" },
        desc = "Structural search and replace",
      },
    },
    opts = {},
  },
}
