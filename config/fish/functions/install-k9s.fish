function install-k9s \
    --argument-names k9s_version

    if command -q k9s and test (k9s version -s | grep -oP 'v\d+\.\d+\.\d+') = $k9s_version
        echo "k9s version $k9s_version already installed."
        return
    end

    echo "Installing k9s version $k9s_version from GitHub"

    curl -qL https://github.com/derailed/k9s/releases/download/$k9s_version/k9s_Linux_x86_64.tar.gz \
        | tar xz \
        --directory $HOME/.local/bin \
        k9s

    k9s version
end
