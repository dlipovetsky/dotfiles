function fish_prompt -d "Write out the prompt"
    # This shows up as USER@HOST /home/user/ >, with the directory colored
    # $USER and $hostname are set by fish, so you can just use them
    # instead of using `whoami` and `hostname`
    set __fish_git_prompt_showcolorhints 1
    printf '%s@%s %s%s%s%s\n> ' $USER $hostname \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal) (fish_git_prompt)
end