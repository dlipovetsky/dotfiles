if status is-interactive
    # Commands to run in interactive sessions can go here

    # Standard paths
    fish_add_path -g /home/dlipovetsky/.local/bin

    # AWS Completion from https://github.com/aws/aws-cli/issues/1079#issuecomment-541997810
    if test (command -v aws_completer)
        complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'
    end

    # zoxide
    if test (command -v zoxide)
        zoxide init --cmd cd fish | source

        # zoxide + fzf
        if test (command -v fzf)
            set -gx _ZO_FZF_OPTS "--exact --no-sort --keep-right --height=40% --info=inline --layout=reverse --exit-0 --select-1 --bind=ctrl-z:ignore --preview='\command -p ls -p {2..}'"

            # Binding for fzf of z directory list; bound to Alt+Ctrl+/
            bind \e\c_ "cdi; commandline -f repaint"
        end
    end

    if test (command -v fzf)
        # kubectl
        if test (command -v kubectl)
            kubectl completion fish | source
        end

        # krew
        # See https://krew.sigs.k8s.io/docs/user-guide/setup/install/
        fish_add_path -g $HOME/.krew/bin

    end
end
