git filter-branch --prune-empty --tree-filter '
git config -f .gitconfig lfs.url "http://127.0.0.1:8080/user/repo"
git lfs track "*.npy"
git add .gitattributes .gitconfig

for file in $(git ls-files | xargs git check-attr filter | grep "filter: lfs" | sed -r "s/(.*): filter: lfs/\1/"); do
  echo "Processing ${file}"

  git rm -f --cached ${file}
  echo "Adding $file lfs style"
  git add ${file}
done' --tag-name-filter cat -- --all
