set -gx GOBIN $HOME/.local/go/bin
set -gx GOMODCACHE $HOME/.local/go/bin/pkg/mod
set -gx GOPATH $HOME/.local/go

begin
    set go_version 1.18.3

    # Path of go and gofmt
    fish_add_path -g $GOPATH/$go_version/bin
end

fish_add_path -g $GOBIN
