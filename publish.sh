#!/bin/sh

cp -r resources/public ../public
git checkout master
cp -r ../public/* ./
git add .
git commit . -m "Publish"
git push origin master
git push deploy1 master
git push deploy2 master
rm -rf ../public
