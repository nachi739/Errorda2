#!/bin/bash

# GitHub CLI (gh) がインストールされていることを確認してください
# https://cli.github.com/

# サブモジュールの更新
echo "サブモジュールの更新"
git submodule update --remote

# 現在のブランチ名を取得
current_branch=$(git branch --show-current)

# chrome_extensionsの変更をステージングしてコミット
echo "chrome_extensionsの変更をステージング"
git add chrome_extensions/

echo "chrome_extensionsの最新コミットメッセージを取得"
chrome_commit_message=$(cd chrome_extensions && git log -1 --pretty=%B)

# chrome_extensionsに変更があるか確認
if [ -n "$(git diff --cached --name-only chrome_extensions)" ]; then
    echo "chrome_extensionsのコミットメッセージを作成"
    chrome_commit_message="submodule:chrome_extensions:$chrome_commit_message"

    # 新しいブランチを作成
    new_branch="[update]chrome_extensions-$(date +%Y%m%d%H%M%S)"
    git checkout -b "$new_branch"

    echo "chrome_extensionsのコミット"
    git commit -m "$chrome_commit_message"

    echo "新しいブランチをプッシュ"
    git push origin "$new_branch"

    echo "プルリクエストを作成"
    gh pr create --title "$chrome_commit_message" --body "This PR updates the chrome_extensions submodule." --base main --head "$new_branch"

    # 元のブランチに戻る
    git checkout "$current_branch"
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
    errorda2_commit_message="submodule:errorda2_backend:$errorda2_commit_message"

    # 新しいブランチを作成
    new_branch="[update]errorda2_backend-$(date +%Y%m%d%H%M%S)"
    git checkout -b "$new_branch"

    echo "errorda2_backendのコミット"
    git commit -m "$errorda2_commit_message"

    echo "新しいブランチをプッシュ"
    git push origin "$new_branch"

    echo "プルリクエストを作成"
    gh pr create --title "$errorda2_commit_message" --body "This PR updates the errorda2_backend submodule." --base main --head "$new_branch"

    # 元のブランチに戻る
    git checkout "$current_branch"
else
    echo "errorda2_backendに変更はありません"
fi