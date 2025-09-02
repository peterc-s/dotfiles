function sup --description "Start SSH agent and add keys"
    # Start SSH agent
    eval (ssh-agent -c)
    
    # Find public/private key pairs
    for pubkey in ~/.ssh/*.pub
        if test -f $pubkey
            set privkey (string replace '.pub' '' $pubkey)
            if test -f $privkey
                ssh-add $privkey
            end
        end
    end
    
    # Add any keys that ssh-add can auto-detect
    ssh-add 2>/dev/null
end
