# From https://gist.github.com/lukechilds/a83e1d7127b78fef38c2914c4ececc3c#gistcomment-3546001
function get_latest_release_version \
    --argument-names user_repo

    curl \
        --silent \
        "https://api.github.com/repos/$user_repo/releases/latest" \
    | string match --regex  '"tag_name": "\K.*?(?=")'
end
