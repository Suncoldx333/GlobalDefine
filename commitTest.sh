#!/bin/bash

echo "hello bash"

git add .
git commit -m "测试commit"
git tag 0.1.0
git push origin master --tags

echo "测试完毕"