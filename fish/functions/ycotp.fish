function ycotp -d "Get a TOTP via ykman and copy it to the Wayland clipboard"
    if not type -q wl-copy
        echo "ycotp: 'wl-copy' not found (install the wl-clipboard package)." >&2
        return 127
    end

    if test (count $argv) -eq 0
        echo "Usage: ycotp <account>" >&2
        return 2
    end

    set -l line (ykman oath accounts code $argv 2>/dev/null)
    if test $status -ne 0
        echo "ycotp: failed to get code (check the account name and try again)." >&2
        return 1
    end

    set -l code (string split -m1 -r ' ' -- $line | tail -n1)
    if test -z "$code"
        echo "ycotp: could not parse code." >&2
        return 1
    end

    # copy to clipboard
    printf %s "$code" | wl-copy
end

# tab completion
complete -c ycotp -a '(ykman oath accounts list)' -f
