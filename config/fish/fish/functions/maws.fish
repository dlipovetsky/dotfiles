function maws
    exec bash -c "eval \$(maws $argv); exec fish"
end