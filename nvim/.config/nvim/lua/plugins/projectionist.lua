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
