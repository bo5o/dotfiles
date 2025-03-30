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

  typeset -g POWERLEVEL9K_MISE_FOREGROUND=66

  typeset -g POWERLEVEL9K_MISE_SHOW_ON_UPGLOB=

  # Ruby version from asdf.
  typeset -g POWERLEVEL9K_MISE_RUBY_FOREGROUND=168
  # typeset -g POWERLEVEL9K_MISE_RUBY_VISUAL_IDENTIFIER_EXPANSION='⭐'
  # typeset -g POWERLEVEL9K_MISE_RUBY_SHOW_ON_UPGLOB='*.foo|*.bar'

  # Python version from asdf.
  typeset -g POWERLEVEL9K_MISE_PYTHON_FOREGROUND=37
  # typeset -g POWERLEVEL9K_MISE_PYTHON_VISUAL_IDENTIFIER_EXPANSION='⭐'
  # typeset -g POWERLEVEL9K_MISE_PYTHON_SHOW_ON_UPGLOB='*.foo|*.bar'
  typeset -g POWERLEVEL9K_MISE_PYTHON_PROMPT_ALWAYS_SHOW=true
  typeset -g POWERLEVEL9K_MISE_PYTHON_SHOW_ON_UPGLOB='*.py|requirements.txt|pyproject.toml'

  # Go version from asdf.
  typeset -g POWERLEVEL9K_MISE_GO_FOREGROUND=37
  # typeset -g POWERLEVEL9K_MISE_GO_VISUAL_IDENTIFIER_EXPANSION='⭐'
  # typeset -g POWERLEVEL9K_MISE_GO_SHOW_ON_UPGLOB='*.foo|*.bar'

  # Jq version from asdf.
  typeset -g POWERLEVEL9K_MISE_JQ_FOREGROUND=37
  typeset -g POWERLEVEL9K_MISE_JQ_VISUAL_IDENTIFIER_EXPANSION=' '
  # typeset -g POWERLEVEL9K_MISE_JQ_SHOW_ON_UPGLOB='*.foo|*.bar'

  # Node.js version from asdf.
  typeset -g POWERLEVEL9K_MISE_NODE_FOREGROUND=70
  # typeset -g POWERLEVEL9K_MISE_NODE_VISUAL_IDENTIFIER_EXPANSION='⭐'
  # typeset -g POWERLEVEL9K_MISE_NODE_SHOW_ON_UPGLOB='*.foo|*.bar'
  typeset -g POWERLEVEL9K_MISE_NODE_PROMPT_ALWAYS_SHOW=true
  typeset -g POWERLEVEL9K_MISE_NODE_SHOW_ON_UPGLOB='*.js|package.json'

  # hadolint version from asdf
  typeset -g POWERLEVEL9K_MISE_HADOLINT_FOREGROUND=172
  typeset -g POWERLEVEL9K_MISE_HADOLINT_VISUAL_IDENTIFIER_EXPANSION='󰄛 '
  typeset -g POWERLEVEL9K_MISE_HADOLINT_SHOW_ON_UPGLOB='Dockerfile'

  # Rust version from asdf.
  typeset -g POWERLEVEL9K_MISE_RUST_FOREGROUND=37
  # typeset -g POWERLEVEL9K_MISE_RUST_VISUAL_IDENTIFIER_EXPANSION='⭐'
  # typeset -g POWERLEVEL9K_MISE_RUST_SHOW_ON_UPGLOB='*.foo|*.bar'

  # .NET Core version from asdf.
  typeset -g POWERLEVEL9K_MISE_DOTNET_CORE_FOREGROUND=134
  # typeset -g POWERLEVEL9K_MISE_DOTNET_CORE_VISUAL_IDENTIFIER_EXPANSION='⭐'
  # typeset -g POWERLEVEL9K_MISE_DOTNET_SHOW_ON_UPGLOB='*.foo|*.bar'

  # Flutter version from asdf.
  typeset -g POWERLEVEL9K_MISE_FLUTTER_FOREGROUND=38
  # typeset -g POWERLEVEL9K_MISE_FLUTTER_VISUAL_IDENTIFIER_EXPANSION='⭐'
  # typeset -g POWERLEVEL9K_MISE_FLUTTER_SHOW_ON_UPGLOB='*.foo|*.bar'

  # Lua version from asdf.
  typeset -g POWERLEVEL9K_MISE_LUA_FOREGROUND=32
  # typeset -g POWERLEVEL9K_MISE_LUA_VISUAL_IDENTIFIER_EXPANSION='⭐'
  # typeset -g POWERLEVEL9K_MISE_LUA_SHOW_ON_UPGLOB='*.foo|*.bar'

  # Java version from asdf.
  typeset -g POWERLEVEL9K_MISE_JAVA_FOREGROUND=32
  # typeset -g POWERLEVEL9K_MISE_JAVA_VISUAL_IDENTIFIER_EXPANSION='⭐'
  # typeset -g POWERLEVEL9K_MISE_JAVA_SHOW_ON_UPGLOB='*.foo|*.bar'

  # Perl version from asdf.
  typeset -g POWERLEVEL9K_MISE_PERL_FOREGROUND=67
  # typeset -g POWERLEVEL9K_MISE_PERL_VISUAL_IDENTIFIER_EXPANSION='⭐'
  # typeset -g POWERLEVEL9K_MISE_PERL_SHOW_ON_UPGLOB='*.foo|*.bar'

  # Erlang version from asdf.
  typeset -g POWERLEVEL9K_MISE_ERLANG_FOREGROUND=125
  # typeset -g POWERLEVEL9K_MISE_ERLANG_VISUAL_IDENTIFIER_EXPANSION='⭐'
  # typeset -g POWERLEVEL9K_MISE_ERLANG_SHOW_ON_UPGLOB='*.foo|*.bar'

  # Elixir version from asdf.
  typeset -g POWERLEVEL9K_MISE_ELIXIR_FOREGROUND=129
  # typeset -g POWERLEVEL9K_MISE_ELIXIR_VISUAL_IDENTIFIER_EXPANSION='⭐'
  # typeset -g POWERLEVEL9K_MISE_ELIXIR_SHOW_ON_UPGLOB='*.foo|*.bar'

  # Postgres version from asdf.
  typeset -g POWERLEVEL9K_MISE_POSTGRES_FOREGROUND=31
  typeset -g POWERLEVEL9K_MISE_POSTGRES_VISUAL_IDENTIFIER_EXPANSION=' '
  # typeset -g POWERLEVEL9K_MISE_POSTGRES_SHOW_ON_UPGLOB='*.foo|*.bar'

  # PHP version from asdf.
  typeset -g POWERLEVEL9K_MISE_PHP_FOREGROUND=99
  # typeset -g POWERLEVEL9K_MISE_PHP_VISUAL_IDENTIFIER_EXPANSION='⭐'
  # typeset -g POWERLEVEL9K_MISE_PHP_SHOW_ON_UPGLOB='*.foo|*.bar'

  # Haskell version from asdf.
  typeset -g POWERLEVEL9K_MISE_HASKELL_FOREGROUND=172
  # typeset -g POWERLEVEL9K_MISE_HASKELL_VISUAL_IDENTIFIER_EXPANSION='⭐'
  # typeset -g POWERLEVEL9K_MISE_HASKELL_SHOW_ON_UPGLOB='*.foo|*.bar'

  # Julia version from asdf.
  typeset -g POWERLEVEL9K_MISE_JULIA_FOREGROUND=70
  # typeset -g POWERLEVEL9K_MISE_JULIA_VISUAL_IDENTIFIER_EXPANSION='⭐'
  # typeset -g POWERLEVEL9K_MISE_JULIA_SHOW_ON_UPGLOB='*.foo|*.bar'

  # Hcloud version from asdf.
  typeset -g POWERLEVEL9K_MISE_HCLOUD_FOREGROUND=160
  typeset -g POWERLEVEL9K_MISE_HCLOUD_VISUAL_IDENTIFIER_EXPANSION=' '
  # typeset -g POWERLEVEL9K_MISE_HCLOUD_SHOW_ON_UPGLOB='*.foo|*.bar'

  # Bitwarden secrets manager version from asdf.
  typeset -g POWERLEVEL9K_MISE_BITWARDEN_SECRETS_MANAGER_FOREGROUND=25
  typeset -g POWERLEVEL9K_MISE_BITWARDEN_SECRETS_MANAGER_VISUAL_IDENTIFIER_EXPANSION='󰞀 '
  # typeset -g POWERLEVEL9K_MISE_BITWARDEN_SECRETS_MANAGER_SHOW_ON_UPGLOB='*.foo|*.bar'

  # Substitute the default asdf prompt element
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=("${POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS[@]/asdf/mise}")
}
