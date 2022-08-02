local M = {}

function M.config()
  local hop = require("hop")
  hop.setup({
    keys = "arsdheiqwfpgjluy;zxcvbkmtn",
  })

  vim.keymap.set("n", "<leader><leader>", function()
    hop.hint_words()
  end, { desc = "hop word" })

  vim.keymap.set("n", "S", function()
    hop.hint_char2()
  end, { desc = "hop sneak" })

  vim.keymap.set("n", "s", function()
    hop.hint_char2()
  end, { desc = "hop sneak" })
end

return M
