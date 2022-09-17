local M = {}

function M.setup()
  vim.g.projectionist_heuristics = {
    ["setup.py|requirements.txt|pyproject.toml"] = {
      ["scripts/*.py"] = {
        type = "script",
        start = "-wait=always ipython --pdb {file}",
      },
      ["src/*.py"] = {
        type = "source",
        alternate = "tests/unit/{dirname|basename}/test_{basename}.py",
        start = "-wait=always ipython --pdb -m {dot}",
      },
      ["tests/unit/**/test_*.py"] = {
        type = "test",
        start = "{project}",
        alternate = "src/{project|basename}/{dirname}/{basename}.py",
      },
      ["README.md"] = {
        type = "readme",
      },
      [".env"] = {
        type = "env",
      },
    },
  }
end

function M.config()
  vim.keymap.set("n", "<leader>aa", "<cmd>A<cr>", { desc = "Open alternate file" })
  vim.keymap.set(
    "n",
    "<leader>av",
    "<cmd>AV<cr>",
    { desc = "Open alternate file in vertical split" }
  )
  vim.keymap.set("n", "<leader>et", "<cmd>Etest<cr>", { desc = "Edit test" })
  vim.keymap.set(
    "n",
    "<leader>evt",
    "<cmd>Vtest<cr>",
    { desc = "Edit test in vertical split" }
  )
  vim.keymap.set("n", "<leader>es", "<cmd>Esource<cr>", { desc = "Edit source" })
  vim.keymap.set(
    "n",
    "<leader>evs",
    "<cmd>Vsource<cr>",
    { desc = "Edit source in vertical split" }
  )
end

return M
