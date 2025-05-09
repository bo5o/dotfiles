[private]
default:
    @just --list zsh --unsorted

githubusercontent := "https://raw.githubusercontent.com"
plugin_dir := "zsh/.oh-my-zsh/custom/plugins"

# upgrade zsh plugins
upgrade:
    @echo -n "Updating github-cli..."
    @mkdir -p {{ plugin_dir }}/gh && \
        mise exec github-cli -- gh completion -s zsh > {{ plugin_dir }}/gh/_gh
    @echo "DONE"

    @echo -n "Updating just..."
    @mkdir -p {{ plugin_dir }}/just && \
        mise exec just -- just --completions zsh > {{ plugin_dir }}/just/_just
    @echo "DONE"

    @echo -n "Updating restic..."
    @mkdir -p {{ plugin_dir }}/restic && \
        mise exec restic -- restic -q generate --zsh-completion {{ plugin_dir }}/restic/_restic
    @echo "DONE"

    @echo -n "Updating hcloud..."
    @mkdir -p {{ plugin_dir }}/hcloud && \
        mise exec hcloud -- hcloud completion zsh > {{ plugin_dir }}/hcloud/_hcloud
    @echo "DONE"

    @echo -n "Updating ruff..."
    @mkdir -p {{ plugin_dir }}/ruff && \
        mise exec ruff -- ruff generate-shell-completion zsh > {{ plugin_dir }}/ruff/_ruff
    @echo "DONE"

    @echo -n "Updating bitwarden-secrets-manager..."
    @mkdir -p {{ plugin_dir }}/bws && \
        mise exec bitwarden-secrets-manager -- bws completions zsh > {{ plugin_dir }}/bws/_bws
    @echo "DONE"

    @echo -n "Updating ripgrep..."
    @mkdir -p {{ plugin_dir }}/rg && \
        mise exec ripgrep -- rg --generate complete-zsh > {{ plugin_dir }}/rg/_rg
    @echo "DONE"

    @echo -n "Updating mise..."
    @mkdir -p {{ plugin_dir }}/mise && \
        mise completion zsh > {{ plugin_dir }}/mise/_mise
    @echo "DONE"

    @echo -n "Updating tldr..."
    @mkdir -p {{ plugin_dir }}/tldr && \
        curl -s {{ githubusercontent }}/tldr-pages/tlrc/main/completions/_tldr \
            --output {{ plugin_dir }}/tldr/_tldr
    @echo "DONE"

    @echo -n "Updating fd..."
    @mkdir -p {{ plugin_dir }}/fd && \
        curl -s {{ githubusercontent }}/sharkdp/fd/refs/heads/master/contrib/completion/_fd \
            --output {{ plugin_dir }}/fd/_fd
    @git submodule update --init --recursive
    @echo "DONE"

    @echo -n "Updating zsh-completions..."
    @git -C {{ plugin_dir }}/zsh-completions pull -q
    @echo "DONE"

    @echo -n "Updating zsh-syntax-highlighting..."
    @git -C {{ plugin_dir }}/zsh-syntax-highlighting pull -q
    @echo "DONE"
