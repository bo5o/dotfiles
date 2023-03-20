local M = {}

function M.config()
  require("colorizer").setup({
    filetypes = {
      "vim",
      "css",
      "html",
      "javascript",
      "typescript",
      "lua",
      html = {
        mode = "background",
      },
    },
  })
end

return M
