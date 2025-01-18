-- Close all buffer except the current one
vim.api.nvim_create_user_command("BufOnly", [[silent! execute "%bd|e#|bd#"]], {})

-- automatically highlight yanked region
local highlight_yank = vim.api.nvim_create_augroup("highlight_yank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = { "*" },
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
  end,
  group = highlight_yank,
  desc = "Highlight yanked region",
})

local terminal_settings =
  vim.api.nvim_create_augroup("terminal_settings", { clear = true })

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = { "*" },
  group = terminal_settings,
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
  desc = "Disable line numbers in terminal buffers",
})

local file_type_settings =
  vim.api.nvim_create_augroup("FileTypeSettings", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "yaml",
    "html",
    "css",
    "javascript",
    "typescript",
    "json",
    "vue",
    "tex",
    "bib",
    "xml",
    "lua",
  },
  group = file_type_settings,
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

-- Expand 'cc' and 'ccc' into 'CodeCompanion' and 'CodeCompanionChat'
vim.cmd([[cab cc CodeCompanion]])
vim.cmd([[cab ccc CodeCompanionChat]])

local function augroup(name)
  return vim.api.nvim_create_augroup("my_" .. name, { clear = true })
end

-- close some filetypes with <q>
-- from https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "checkhealth",
    "gitsigns-blame",
    "grug-far",
    "help",
    "lspinfo",
    "neotest-output",
    "neotest-output-panel",
    "neotest-summary",
    "notify",
    "qf",
    "startuptime",
    "tsplayground",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        vim.cmd("close")
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = "Quit buffer",
      })
    end)
  end,
})

-- go to last loc when opening a buffer
-- from https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].my_last_loc then
      return
    end
    vim.b[buf].my_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "dbout",
    "dbui",
  },
  group = augroup("dadbod_dbout"),
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.colorcolumn = ""
  end,
})
