function gitbr --description 'Create a new branch and push it to remote' -a branch remote
    if not string length -q $remote
        set remote origin
    end

    git checkout -b $branch
    git push --set-upstream $remote $branch
end
