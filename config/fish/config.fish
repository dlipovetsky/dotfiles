# Commands to run in interactive sessions can go here
if status is-interactive

    # Standard paths
    fish_add_path -g /home/dlipovetsky/.local/bin

    # Editor
    if test (command -v nvim)
        set -x -g EDITOR $(command -v nvim)
    end

    # XDG Configuration Directory
    # By default, the variable is not set, although the value is $HOME/.config.
    # We make the variable available for other programs.
    set -x -g XDG_CONFIG_HOME $HOME/.config
    if ! test -d $XDG_CONFIG_HOME
        mkdir -p $XDG_CONFIG_HOME
    end

    # AWS Completion from https://github.com/aws/aws-cli/issues/1079#issuecomment-541997810
    if test (command -v aws_completer)
        complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'
    end

    # patrickf1/fzf.fish
    if functions -q fzf_configure_bindings
        fzf_configure_bindings --variables=\e\cv
    end

    # fd
    if test (command -v fd)
        set fzf_fd_opts \
            --no-ignore \
            --hidden \
            --absolute-path \
            --exclude=.git
    end

    # zoxide
    if test (command -v zoxide)
        set zc cd
        zoxide init --cmd $zc fish | source

        # zoxide + fzf
        if test (command -v fzf)
            set -gx _ZO_FZF_OPTS "--exact --no-sort --keep-right --height=40% --info=inline --layout=reverse --exit-0 --select-1 --bind=ctrl-z:ignore --preview='\command -p ls -p {2..}'"

            # Binding for fzf of z directory list; bound to Alt+Ctrl+/
            bind \e\c_ '$zc"i"; commandline -f repaint'
        end
    end

    # kubectl
    if test (command -v kubectl)
        kubectl completion fish | source

        # krew
        # See https://krew.sigs.k8s.io/docs/user-guide/setup/install/
        fish_add_path -g $HOME/.krew/bin
    end

    # kind
    if test (command -v kind)
        kind completion fish | source
    end

    # pure prompt
    if test (command -v fisher)
        and test (fisher list pure-fish/pure)
        _pure_set_default pure_show_system_time true
        _pure_set_default pure_threshold_command_duration 0
        _pure_set_default pure_show_subsecond_command_duration true
        _pure_set_default pure_separate_prompt_on_error true
    end

    # select code workspaces
    if test (command -v code)
        and test (command -v fzf)

        # Binding for fzf of code workspaces; bound to Alt+Ctrl+W
        bind \e\cw 'select-code-workspace $HOME; commandline -f repaint'
    end

    # default terminal editor
    if test (command -v vim)
        set -x -g EDITOR vim
    end

    # asdf
    # if test -e ~/.asdf/asdf.fish
    #     source ~/.asdf/asdf.fish
    # end

    # virsh
    # The default URI is qemu:///session, which nothing uses, apparently, except virsh.
    # Which you discover when you run `virsh`, and nothing shows up.
    # Also see https://blog.wikichoon.com/2016/01/qemusystem-vs-qemusession.html
    if test (command -v virsh)
        set -x -g VIRSH_DEFAULT_CONNECT_URI qemu:///system
    end

    # less (pager)
    if test (command -v less)
        set -x -g LESS \
            --ignore-case \
            --quit-if-one-screen \
            --RAW-CONTROL-CHARS \
            --use-color
    end

    # rg (search)
    if test (command -v rg)
        set -x -g RIPGREP_CONFIG_PATH $XDG_CONFIG_HOME/ripgreprc
    end
end
