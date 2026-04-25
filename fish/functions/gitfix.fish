function gitfix --description 'Create a fixup commit, rebase with autosquash, and force push with lease.' 
  git commit --fixup HEAD && git rebase --autosquash HEAD~2 && git push --force-with-lease
end
