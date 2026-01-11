function shellcode -a binary --description "Extract shellcode bytes from a binary executable using objdump"
    if not test -f $binary
        echo "Error: File '$binary' not found" >&2
        return 1
    end
    
    if not test -x $binary
        echo "Warning: '$binary' is not executable" >&2
    end
    
    set -l objdump_bytes (objdump -d $binary | grep "^ " | cut -f2)
    
    if echo $objdump_bytes | grep -q "00"
        echo "Warning: NULL bytes (00) found in shellcode" >&2
    end
    
    for i in (echo $objdump_bytes | sed 's/ //g')
        echo -n $i
    end
    
    if isatty stdout
        echo
    end
end
