#!/bin/bash

echo "サブモジュールの更新"
git submodule update --remote

# chrome_extensionsの変更をステージングしてコミット
echo "chrome_extensionsの変更をステージング"
git add chrome_extensions/

echo "chrome_extensionsの最新コミットメッセージを取得"
chrome_commit_message=$(cd chrome_extensions && git log -1 --pretty=%B)

# chrome_extensionsに変更があるか確認
if [ -n "$(git diff --cached --name-only chrome_extensions)" ]; then
    echo "chrome_extensionsのコミットメッセージを作成"
    chrome_commit_message="[update] submodule: chrome_extensions: $chrome_commit_message"

    echo "chrome_extensionsのコミット"
    git commit -m "$chrome_commit_message"

    echo "chrome_extensionsのプッシュ"
    git push origin main
else
    echo "chrome_extensionsに変更はありません"
fi

# errorda2_backendの変更をステージングしてコミット
echo "errorda2_backendの変更をステージング"
git add errorda2_backend/

echo "errorda2_backendの最新コミットメッセージを取得"
errorda2_commit_message=$(cd errorda2_backend && git log -1 --pretty=%B)

# errorda2_backendに変更があるか確認
if [ -n "$(git diff --cached --name-only errorda2_backend)" ]; then
    echo "errorda2_backendのコミットメッセージを作成"
    errorda2_commit_message="[update] submodule: errorda2_backend: $errorda2_commit_message"

    echo "errorda2_backendのコミット"
    git commit -m "$errorda2_commit_message"

    echo "errorda2_backendのプッシュ"
    git push origin main
else
    echo "errorda2_backendに変更はありません"
fi