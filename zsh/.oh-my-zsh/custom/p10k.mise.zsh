# source: https://github.com/2KAbhishek/dots2k/blob/main/config/zsh/prompt/p10k.mise.zsh
() {
  function prompt_mise() {
    local plugins=("${(@f)$(mise ls --current --offline 2>/dev/null | awk '!/\(symlink\)/ && $3!="~/.tool-versions" && $3!="~/.config/mise/config.toml" && $3!="(missing)" {print $1, $2}')}")
    local plugin
    for plugin in ${(k)plugins}; do
      local parts=("${(@s/ /)plugin}")
      local tool=${${(U)parts[1]}#*:}
      local version=${parts[2]}
      p10k segment -r -i "${tool}_ICON" -s $tool -t "$version"
    done
  }

  typeset -g POWERLEVEL9K_MISE_FOREGROUND='#d4be98'

  typeset -g POWERLEVEL9K_MISE_SHOW_ON_UPGLOB=

  # Ruby version from mise.
  typeset -g POWERLEVEL9K_MISE_RUBY_FOREGROUND='#ea6962'
  typeset -g POWERLEVEL9K_MISE_RUBY_VISUAL_IDENTIFIER_EXPANSION=' '
  # typeset -g POWERLEVEL9K_MISE_RUBY_SHOW_ON_UPGLOB='*.foo|*.bar'

  # Python version from mise.
  typeset -g POWERLEVEL9K_MISE_PYTHON_FOREGROUND='#d8a657'
  typeset -g POWERLEVEL9K_MISE_PYTHON_VISUAL_IDENTIFIER_EXPANSION=' '
  # typeset -g POWERLEVEL9K_MISE_PYTHON_SHOW_ON_UPGLOB='*.foo|*.bar'
  typeset -g POWERLEVEL9K_MISE_PYTHON_PROMPT_ALWAYS_SHOW=true
  typeset -g POWERLEVEL9K_MISE_PYTHON_SHOW_ON_UPGLOB='*.py|requirements.txt|pyproject.toml'

  # Go version from mise.
  typeset -g POWERLEVEL9K_MISE_GO_FOREGROUND='#7daea3'
  typeset -g POWERLEVEL9K_MISE_GO_VISUAL_IDENTIFIER_EXPANSION=' '
  # typeset -g POWERLEVEL9K_MISE_GO_SHOW_ON_UPGLOB='*.foo|*.bar'

  # jq version from mise.
  typeset -g POWERLEVEL9K_MISE_JQ_FOREGROUND='#928374'
  typeset -g POWERLEVEL9K_MISE_JQ_VISUAL_IDENTIFIER_EXPANSION=' '
  # typeset -g POWERLEVEL9K_MISE_JQ_SHOW_ON_UPGLOB='*.foo|*.bar'

  # Node.js version from mise.
  typeset -g POWERLEVEL9K_MISE_NODE_FOREGROUND='#a9b665'
  typeset -g POWERLEVEL9K_MISE_NODE_VISUAL_IDENTIFIER_EXPANSION=' '
  # typeset -g POWERLEVEL9K_MISE_NODE_SHOW_ON_UPGLOB='*.foo|*.bar'
  typeset -g POWERLEVEL9K_MISE_NODE_PROMPT_ALWAYS_SHOW=true
  typeset -g POWERLEVEL9K_MISE_NODE_SHOW_ON_UPGLOB='*.js|package.json'

  # hadolint version from asdf
  typeset -g POWERLEVEL9K_MISE_HADOLINT_FOREGROUND='#7daea3'
  typeset -g POWERLEVEL9K_MISE_HADOLINT_VISUAL_IDENTIFIER_EXPANSION='󰄛 '
  typeset -g POWERLEVEL9K_MISE_HADOLINT_SHOW_ON_UPGLOB='Dockerfile'

  # duckdb version from mise
  typeset -g POWERLEVEL9K_MISE_DUCKDB_FOREGROUND='#d8a657'
  typeset -g POWERLEVEL9K_MISE_DUCKDB_VISUAL_IDENTIFIER_EXPANSION='󰇥 '

  # poetry version from mise
  typeset -g POWERLEVEL9K_MISE_POETRY_FOREGROUND='#7daea3'
  typeset -g POWERLEVEL9K_MISE_POETRY_VISUAL_IDENTIFIER_EXPANSION=' '

  # marimo version from mise
  typeset -g POWERLEVEL9K_MISE_MARIMO_FOREGROUND='#a9b665'
  typeset -g POWERLEVEL9K_MISE_MARIMO_VISUAL_IDENTIFIER_EXPANSION='󰠮 '

  # sqlfluff version from mise
  typeset -g POWERLEVEL9K_MISE_SQLFLUFF_FOREGROUND='#ddc7a1'
  typeset -g POWERLEVEL9K_MISE_SQLFLUFF_VISUAL_IDENTIFIER_EXPANSION=' '

  # Rust version from mise.
  typeset -g POWERLEVEL9K_MISE_RUST_FOREGROUND='#ea6962'
  typeset -g POWERLEVEL9K_MISE_RUST_VISUAL_IDENTIFIER_EXPANSION=' '
  # typeset -g POWERLEVEL9K_MISE_RUST_SHOW_ON_UPGLOB='*.foo|*.bar'

  # .NET Core version from mise.
  typeset -g POWERLEVEL9K_MISE_DOTNET_CORE_FOREGROUND='#d3869b'
  typeset -g POWERLEVEL9K_MISE_DOTNET_CORE_VISUAL_IDENTIFIER_EXPANSION=' '
  # typeset -g POWERLEVEL9K_MISE_DOTNET_SHOW_ON_UPGLOB='*.foo|*.bar'

  # Flutter version from mise.
  typeset -g POWERLEVEL9K_MISE_FLUTTER_FOREGROUND='#7daea3'
  typeset -g POWERLEVEL9K_MISE_FLUTTER_VISUAL_IDENTIFIER_EXPANSION=' '
  # typeset -g POWERLEVEL9K_MISE_FLUTTER_SHOW_ON_UPGLOB='*.foo|*.bar'

  # Lua version from mise.
  typeset -g POWERLEVEL9K_MISE_LUA_FOREGROUND='#7daea3'
  typeset -g POWERLEVEL9K_MISE_LUA_VISUAL_IDENTIFIER_EXPANSION=' '
  # typeset -g POWERLEVEL9K_MISE_LUA_SHOW_ON_UPGLOB='*.foo|*.bar'

  # Java version from mise.
  typeset -g POWERLEVEL9K_MISE_JAVA_FOREGROUND='#e78a4e'
  typeset -g POWERLEVEL9K_MISE_JAVA_VISUAL_IDENTIFIER_EXPANSION=' '
  # typeset -g POWERLEVEL9K_MISE_JAVA_SHOW_ON_UPGLOB='*.foo|*.bar'

  # Perl version from mise.
  typeset -g POWERLEVEL9K_MISE_PERL_FOREGROUND='#7daea3'
  typeset -g POWERLEVEL9K_MISE_PERL_VISUAL_IDENTIFIER_EXPANSION=' '
  # typeset -g POWERLEVEL9K_MISE_PERL_SHOW_ON_UPGLOB='*.foo|*.bar'

  # Erlang version from mise.
  typeset -g POWERLEVEL9K_MISE_ERLANG_FOREGROUND='#ea6962'
  typeset -g POWERLEVEL9K_MISE_ERLANG_VISUAL_IDENTIFIER_EXPANSION=' '
  # typeset -g POWERLEVEL9K_MISE_ERLANG_SHOW_ON_UPGLOB='*.foo|*.bar'

  # Elixir version from mise.
  typeset -g POWERLEVEL9K_MISE_ELIXIR_FOREGROUND='#d3869b'
  typeset -g POWERLEVEL9K_MISE_ELIXIR_VISUAL_IDENTIFIER_EXPANSION=' '
  # typeset -g POWERLEVEL9K_MISE_ELIXIR_SHOW_ON_UPGLOB='*.foo|*.bar'

  # Postgres version from mise.
  typeset -g POWERLEVEL9K_MISE_POSTGRES_FOREGROUND='#7daea3'
  typeset -g POWERLEVEL9K_MISE_POSTGRES_VISUAL_IDENTIFIER_EXPANSION=' '
  # typeset -g POWERLEVEL9K_MISE_POSTGRES_SHOW_ON_UPGLOB='*.foo|*.bar'

  # PHP version from mise.
  typeset -g POWERLEVEL9K_MISE_PHP_FOREGROUND='#d3869b'
  typeset -g POWERLEVEL9K_MISE_PHP_VISUAL_IDENTIFIER_EXPANSION=' '
  # typeset -g POWERLEVEL9K_MISE_PHP_SHOW_ON_UPGLOB='*.foo|*.bar'

  # Haskell version from mise.
  typeset -g POWERLEVEL9K_MISE_HASKELL_FOREGROUND='#d3869b'
  typeset -g POWERLEVEL9K_MISE_HASKELL_VISUAL_IDENTIFIER_EXPANSION=' '
  # typeset -g POWERLEVEL9K_MISE_HASKELL_SHOW_ON_UPGLOB='*.foo|*.bar'

  # Just version from mise.
  typeset -g POWERLEVEL9K_MISE_JUST_FOREGROUND='#a89984'
  typeset -g POWERLEVEL9K_MISE_JUST_VISUAL_IDENTIFIER_EXPANSION=' '

  # uv version from mise.
  typeset -g POWERLEVEL9K_MISE_UV_FOREGROUND='#d3869b'
  typeset -g POWERLEVEL9K_MISE_UV_VISUAL_IDENTIFIER_EXPANSION='󱓞 '

  # gcloud version from mise.
  typeset -g POWERLEVEL9K_MISE_GCLOUD_FOREGROUND='#7daea3'
  typeset -g POWERLEVEL9K_MISE_GCLOUD_VISUAL_IDENTIFIER_EXPANSION=' '

  # Julia version from mise.
  typeset -g POWERLEVEL9K_MISE_JULIA_FOREGROUND='#a9b665'
  typeset -g POWERLEVEL9K_MISE_JULIA_VISUAL_IDENTIFIER_EXPANSION=' '
  # typeset -g POWERLEVEL9K_MISE_JULIA_SHOW_ON_UPGLOB='*.foo|*.bar'

  # Hcloud version from mise.
  typeset -g POWERLEVEL9K_MISE_HCLOUD_FOREGROUND='#ea6962'
  typeset -g POWERLEVEL9K_MISE_HCLOUD_VISUAL_IDENTIFIER_EXPANSION=' '
  # typeset -g POWERLEVEL9K_MISE_HCLOUD_SHOW_ON_UPGLOB='*.foo|*.bar'

  # Bitwarden secrets manager version from mise.
  typeset -g POWERLEVEL9K_MISE_BITWARDEN_SECRETS_MANAGER_FOREGROUND='#7daea3'
  typeset -g POWERLEVEL9K_MISE_BITWARDEN_SECRETS_MANAGER_VISUAL_IDENTIFIER_EXPANSION='󰞀 '
  # typeset -g POWERLEVEL9K_MISE_BITWARDEN_SECRETS_MANAGER_SHOW_ON_UPGLOB='*.foo|*.bar'

  # Substitute the default asdf prompt element
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=("${POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS[@]/asdf/mise}")
}
