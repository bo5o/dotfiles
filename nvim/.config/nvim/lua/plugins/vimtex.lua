vim.g.vimtex_view_method = "zathura"
vim.g.tex_flavor = "latex"

local vimtex_event_1 = vim.api.nvim_create_augroup("vimtex_event_1", { clear = true })

vim.api.nvim_create_autocmd("User", {
  pattern = { "VimtexEventInitPost" },
  command = "VimtexCompile",
  group = vimtex_event_1,
  desc = "Compile on initialization",
})

vim.api.nvim_create_autocmd("User", {
  pattern = { "VimtexEventQuit" },
  command = "VimtexClean",
  group = vimtex_event_1,
  desc = "Cleanup on quit",
})

local vimtex_latex_surround =
  vim.api.nvim_create_augroup("vimtex_latex_surround", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "tex" },
  callback = function()
    vim.b["surround_" .. vim.fn.char2nr("e")] =
      "\\begin{\1environment: \1}\n\t\r\n\\end{\1\1}"
    vim.b["surround_" .. vim.fn.char2nr("c")] = "\\\1command: \1{\r}"
  end,
  group = vimtex_latex_surround,
  desc = "Provide surround mappings",
})

vim.g.vimtex_quickfix_latexlog = { overfull = 0, underfull = 0 }
