if did_filetype()
  finish
endif
if getline(1) =~ 'uv run'
  setfiletype python
endif
