function select-code-workspace \
    --argument-names root
    set selection (fd -t file "\.code-workspace" $root | fzf)
    if test -n "$selection"
        code $selection
    end
end
