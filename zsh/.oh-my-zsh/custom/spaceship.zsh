SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_CHAR_SYMBOL="ζ "
SPACESHIP_VENV_PREFIX="in "
SPACESHIP_VENV_COLOR=blue

SPACESHIP_PROMPT_ORDER=(
  # time          # Time stamps section
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  # hg            # Mercurial section (hg_branch  + hg_status)
  package       # Package version
  node          # Node.js section
  # ruby          # Ruby section
  # elixir        # Elixir section
  # xcode         # Xcode section
  # swift         # Swift section
  # golang        # Go section
  # php           # PHP section
  # rust          # Rust section
  # haskell       # Haskell Stack section
  # julia         # Julia section
  # docker        # Docker section
  # aws           # Amazon Web Services section
  # venv          # virtualenv section
  # conda         # conda virtualenv section
  # pyenv         # Pyenv section
  asdf_python   # Python version via asdf
  custom_venv   # custom virtualenv section
  # dotnet        # .NET section
  # ember         # Ember.js section
  # kubectl       # Kubectl context section
  # terraform     # Terraform workspace section
  exec_time     # Execution time
  line_sep      # Line break
  # battery       # Battery level and status
  # vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)
# ------------------------------------------------------------------------------
# Custom sections
# ------------------------------------------------------------------------------

# Python version via asdf
SPACESHIP_ASDF_PYTHON_SHOW=true

spaceship_asdf_python() {
  [[ $SPACESHIP_ASDF_PYTHON_SHOW == false ]] && return

  # Show pyenv python version only for Python-specific folders
  [[ -f .python-version || -f requirements.txt || -f pyproject.toml || -n *.py(#qN^/) ]] || return

  spaceship::exists asdf || return # Do nothing if pyenv is not installed

  local python_version=${$(asdf current python)[1]}

  # Add 'v' before python version that starts with a number
  [[ "${python_version}" =~ ^[0-9].+$ ]] && python_version="v${python_version}"

  spaceship::section \
    "yellow" \
    "$SPACESHIP_PROMPT_DEFAULT_PREFIX" \
    " ${python_version}" \
    "$SPACESHIP_PROMPT_DEFAULT_SUFFIX"
}

# Current active virtual environment, always showing parent directory
SPACESHIP_CUSTOM_VENV_SHOW=true

spaceship_custom_venv() {
  [[ $SPACESHIP_CUSTOM_VENV_SHOW == false ]] && return

  # Check if the current directory running via virtualenv
  [ -n "$VIRTUAL_ENV" ] || return

  local 'venv'

  venv="$VIRTUAL_ENV:h:t"

spaceship::section \
    "$SPACESHIP_VENV_COLOR" \
    "$SPACESHIP_VENV_PREFIX" \
    "${SPACESHIP_VENV_SYMBOL}${venv}" \
    "$SPACESHIP_VENV_SUFFIX"
}
