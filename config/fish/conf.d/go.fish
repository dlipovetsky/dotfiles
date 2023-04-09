set -gx GOBIN $HOME/.local/go/bin
set -gx GOPATH $HOME/.local/go

begin
    set go_version 1.20.1
    # set go_version 1.19.5
    #set go_version 1.18.4
    #set go_version 1.17.8

    # Path of go and gofmt
    fish_add_path -g $GOPATH/$go_version/bin
end

fish_add_path -g $GOBIN
