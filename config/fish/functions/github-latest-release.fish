function github-latest-release \
    --argument-names user_repo

    curl \
        --silent \
        "https://api.github.com/repos/$user_repo/releases/latest" \
    | string match --regex  '"tag_name": "\K.*?(?=")'
end
# From https://gist.github.com/lukechilds/a83e1d7127b78fef38c2914c4ececc3c#gistcomment-3546001
