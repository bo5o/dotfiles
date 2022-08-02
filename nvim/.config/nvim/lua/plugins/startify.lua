local M = {}

function M.config()
  vim.g.startify_list_order = { "files", "dir", "bookmarks", "commands" }
  vim.g.startify_bookmarks = {
    { c = "~/.config/nvim/init.vim" },
    { g = "~/.gitconfig" },
    { p = "~/.oh-my-zsh/custom/p10k.zsh" },
    { t = "~/.tmux.conf" },
    { z = "~/.zshrc" },
  }
  vim.g.startify_change_to_dir = 0
  vim.g.startify_change_to_vcs_root = 0
  vim.g.startify_fortune_use_unicode = 1
  vim.g.startify_files_number = 4
  vim.g.startify_custom_indices = { "1", "2", "3", "4", "7", "8", "9", "0" }
  vim.g.startify_commands = {
    { up = { "Update plugins", ":PackerSync" } },
  }
end

return M
