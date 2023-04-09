function why-installed \
    --argument-names file

    if test -z $file
        return 0
    end

    if test -e $file
        set target $file
    else if test (command -v $file)
        set target (command -v $file)
    else
        return 1
    end

    set fish_trace true
    dnf repoquery --installed --whatprovides $target
end
