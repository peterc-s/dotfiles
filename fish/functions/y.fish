function y --description 'Yazi file explorer'
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set -q cwd; and test -n "$cwd" -a "$cwd" != "$PWD"
        builtin cd -- "$cwd"
    end
    rm -f "$tmp"
end

