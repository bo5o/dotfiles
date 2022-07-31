local telescope = require("telescope")
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

telescope.setup({
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
  defaults = {
    find_command = {
      "rg",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    prompt_prefix = "> ",
    layout_config = {
      prompt_position = "bottom",
      horizontal = {
        mirror = false,
        preview_width = 0.6,
      },
    },
    file_ignore_patterns = {},
    winblend = 0,
    scroll_strategy = "cycle",
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    use_less = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.smart_send_to_loclist + actions.open_loclist,
        ["<CR>"] = actions.select_default + actions.center,
      },
      n = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
      },
    },
  },
})

vim.keymap.set("n", "<leader>fr", function()
  builtin.live_grep({
    additional_args = function(opts)
      return { "--hidden", "--ignore", "--glob=!.git/" }
    end,
  })
end, { silent = true, desc = "Live grep (incl. hidden)" })

local function find_files(opts)
  opts = opts or {}
  local ok = pcall(builtin.git_files, opts)
  if not ok then
    builtin.find_files(opts)
  end
end

vim.keymap.set("n", "<leader>ff", find_files, { silent = true, desc = "Find files" })
