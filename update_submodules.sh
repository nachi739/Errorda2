#!/bin/bash

echo "サブモジュールの更新"
git submodule update --remote

echo "サブモジュールの変更をステージング"
git add chrome_extensions/
git add errorda2_backend/

echo "サブモジュールの最新コミットメッセージを取得"
chrome_commit_message=$(cd chrome_extensions && git log -1 --pretty=%B)
errorda2_commit_message=$(cd errorda2_backend && git log -1 --pretty=%B)

echo "コミットメッセージを作成"
commit_message="[update] submodules: chrome_extensions: $chrome_commit_message, errorda2_backend: $errorda2_commit_message"

echo "コミット"
git commit -m "$commit_message"

echo "プッシュ"
git push origin main