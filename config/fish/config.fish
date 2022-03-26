if status is-interactive
    # Commands to run in interactive sessions can go here

    # AWS Completion from https://github.com/aws/aws-cli/issues/1079#issuecomment-541997810
    if test (command -v aws_completer)
        complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'
    end

    # zoxide
    if test (command -v zoxide)
        zoxide init fish | source
    end

    # kubectl
    if test (command -v kubectl)
        kubectl completion fish | source
    end
end

# krew
# See https://krew.sigs.k8s.io/docs/user-guide/setup/install/
fish_add_path $HOME/.krew/bin
