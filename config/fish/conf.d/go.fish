set -gx GOBIN $HOME/.local/share/go/bin
set -gx GOPATH $HOME/.local/share/go
# Note GOMODCACHE is _not_ under $HOME/.cache by design. See https://github.com/golang/go/issues/34527#issuecomment-603940080

begin
    set go_version 1.21.3

    # Path of go and gofmt
    fish_add_path -g $GOPATH/$go_version/bin
end

fish_add_path -g $GOBIN
