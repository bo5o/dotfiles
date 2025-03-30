[private]
default:
    @just --list --unsorted

githubusercontent := "https://raw.githubusercontent.com"
plugin_dir := "zsh/.oh-my-zsh/custom/plugins"

update-custom-zsh-plugins:
    mkdir -p {{ plugin_dir }}/gh && \
        mise exec github-cli -- gh completion -s zsh > {{ plugin_dir }}/gh/_gh
    mkdir -p {{ plugin_dir }}/just && \
        mise exec just -- just --completions zsh > {{ plugin_dir }}/just/_just
    mkdir -p {{ plugin_dir }}/restic && \
        mise exec restic -- restic generate --zsh-completion {{ plugin_dir }}/restic/_restic
    mkdir -p {{ plugin_dir }}/hcloud && \
        mise exec hcloud -- hcloud completion zsh > {{ plugin_dir }}/hcloud/_hcloud
    mkdir -p {{ plugin_dir }}/ruff && \
        mise exec ruff -- ruff generate-shell-completion zsh > {{ plugin_dir }}/ruff/_ruff
    mkdir -p {{ plugin_dir }}/bws && \
        mise exec bitwarden-secrets-manager -- bws completions zsh > {{ plugin_dir }}/bws/_bws
    mkdir -p {{ plugin_dir }}/rg && \
        mise exec ripgrep -- rg --generate complete-zsh > {{ plugin_dir }}/rg/_rg
    mkdir -p {{ plugin_dir }}/mise && \
        mise completion zsh > {{ plugin_dir }}/mise/_mise
    mkdir -p {{ plugin_dir }}/tldr && \
        curl {{ githubusercontent }}/tldr-pages/tlrc/main/completions/_tldr \
            --output {{ plugin_dir }}/tldr/_tldr
    mkdir -p {{ plugin_dir }}/fd && \
        curl {{ githubusercontent }}/sharkdp/fd/refs/heads/master/contrib/completion/_fd \
            --output {{ plugin_dir }}/fd/_fd
