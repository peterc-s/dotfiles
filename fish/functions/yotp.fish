function yotp -d "Shortcut for 'ykman oath accounts code'"
    if test (count $argv) -eq 0
        ykman oath accounts code
    else
        ykman oath accounts code $argv
    end
end

# tab completion
complete -c yotp -a '(ykman oath accounts list)' -f
