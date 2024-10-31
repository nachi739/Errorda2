#!/bin/bash

# GitHub CLI (gh) がインストールされていることを確認してください
# https://cli.github.com/

# サブモジュールの更新
echo "サブモジュールの更新"
git submodule update --remote

# 現在のブランチ名を取得
current_branch=$(git branch --show-current)

# サブモジュールのプルリクエストリンクを取得する関数
get_submodule_pr_link() {
    local repo=$1
    local pr_link=$(gh pr list --repo "$repo" --state open --json url --jq '.[0].url')
    echo "$pr_link"
}

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
    new_branch="dev-chrome_extensions-$(date +%Y%m%d%H)"
    git checkout -b "$new_branch"

    echo "chrome_extensionsのコミット"
    git commit -m "$chrome_commit_message"

    echo "新しいブランチをプッシュ"
    git push origin "$new_branch"

    # サブモジュールのプルリクエストリンクを取得
    chrome_pr_link=$(get_submodule_pr_link "nachi739/errorda2_chrome_extensions")

    echo "プルリクエストを作成"
    pr_body="This PR updates the chrome_extensions submodule.\n\n## submodule-Pull-requests\n対象のサブモジュールのPull requestのリンク\n$chrome_pr_link"
    gh pr create --title "$new_branch" --body "$pr_body" --base main --head "$new_branch"

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
    new_branch="dev-errorda2_backend-$(date +%Y%m%d%H)"
    git checkout -b "$new_branch"

    echo "errorda2_backendのコミット"
    git commit -m "$errorda2_commit_message"

    echo "新しいブランチをプッシュ"
    git push origin "$new_branch"

    # サブモジュールのプルリクエストリンクを取得
    backend_pr_link=$(get_submodule_pr_link "nachi739/errorda2_backend")

    echo "プルリクエストを作成"
    pr_body="This PR updates the errorda2_backend submodule.\n\n## submodule-Pull-requests\n対象のサブモジュールのPull requestのリンク\n$backend_pr_link"
    gh pr create --title "$new_branch" --body "$pr_body" --base main --head "$new_branch"

    # 元のブランチに戻る
    git checkout "$current_branch"
else
    echo "errorda2_backendに変更はありません"
fi