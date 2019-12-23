yarn build

cd docs

echo 'emoji.toyou.xyz' > CNAME

git add -A
git commit -m 'Deploy'

git push origin master
