#!/bin/bash
# GitHub CLI (gh) がインストール・gh auth login が済んでいることが前提
# 実行時ブランチはmainであることが前提

echo "サブモジュールの更新"
git submodule update --remote

echo "現在のブランチ名を取得"
current_branch=$(git branch --show-current)

# サブモジュールのリポジトリURLを取得する関数
get_submodule_repo_url() {
    local submodule_path=$1
    local repo_url=$(git config --file .gitmodules --get-regexp "submodule\.$submodule_path\.url" | awk '{print $2}')
    echo "$repo_url"
}

# サブモジュールの最新のクローズされたプルリクエストリンクを取得する関数
get_submodule_latest_closed_pr_link() {
    local repo_url=$1
    local repo_name=$(basename -s .git "$repo_url")
    local repo_owner=$(basename $(dirname "$repo_url"))
    local repo="$repo_owner/$repo_name"
    local pr_link=$(gh pr list --repo "$repo" --state closed --json url,updatedAt --jq 'sort_by(.updatedAt) | reverse | .[0].url')
    if [ -z "$pr_link" ]; then
        echo "No closed pull request found for $repo"
    fi
    echo "$pr_link"
}

# サブモジュールのリポジトリURLを取得
chrome_repo_url=$(get_submodule_repo_url "chrome_extensions")
backend_repo_url=$(get_submodule_repo_url "errorda2_backend")

# chrome_extensionsの最新コミットメッセージを取得
chrome_commit_message=$(cd chrome_extensions && git log -1 --pretty=%B)
# chromeのコミットメッセージ内容
chrome_commit_message="submodule_chrome:$chrome_commit_message"
# chromeの新しいブランチ名
new_chrome_branch="dev-chrome_extensions-$(date +%Y%m%d%H)"
# chromeのプルリクエストリンクを取得
chrome_pr_link=$(get_submodule_latest_closed_pr_link "$chrome_repo_url")
# chromeのPRの本文
chrome_pr_body=$(echo -e "## やったこと
\n- サブモジュールの更新内容の反映
\n## なぜやるのか・背景
\n- 修正や追加機能があったため、それらをプロジェクト内に反映する必要があるため
\n## 動作確認
\n- サブモジュール側で実施済み
\n## Refs
\n- 対象のサブモジュールのPull requestのリンク
\n$chrome_pr_link")

# --ここからchrome_extensionsの処理--
echo "chrome_extensionsの変更をステージング(対象以外を含まないために)"
git add chrome_extensions/

# chrome_extensionsに変更があるか確認
if [ -n "$(git diff --cached --name-only chrome_extensions)" ]; then

    echo "新しいブランチを作成し切替"
    git checkout -b "$new_chrome_branch"

    echo "chrome_extensionsのコミット・プッシュ"
    git commit -m "$chrome_commit_message"
    git push origin "$new_chrome_branch"

    echo "プルリクエストを作成"
    gh pr create --title "$new_chrome_branch" --body "$chrome_pr_body" --base main --head "$new_chrome_branch"

    echo "元のブランチに戻る"
    git checkout "$current_branch"

    echo "作成したブランチを削除（ローカルでは不要のため）"
    git branch -D "$new_chrome_branch"
else
    echo "chrome_extensionsに変更はありません"
fi

# errorda2_backendの最新コミットメッセージを取得
backend_commit_message=$(cd errorda2_backend && git log -1 --pretty=%B)
# backendのコミットメッセージ内容
backend_commit_message="submodule_backend:$backend_commit_message"
# backendの新しいブランチ名
new_backend_branch="dev-errorda2_backend-$(date +%Y%m%d%H)"
# backendのプルリクエストリンクを取得
backend_pr_link=$(get_submodule_latest_closed_pr_link "$backend_repo_url")
# backendのPRの本文
backend_pr_body=$(echo -e "## やったこと
\n- サブモジュールの更新内容の反映
\n## なぜやるのか・背景
\n- 修正や追加機能があったため、それらをプロジェクト内に反映する必要があるため
\n## 動作確認
\n- サブモジュール側で実施済み
\n## Refs
\n- 対象のサブモジュールのPull requestのリンク
\n$backend_pr_link")

# --ここからerrorda2_backendの処理--
echo "errorda2_backendの変更をステージング(対象以外を含まないために)"
git add errorda2_backend/

# errorda2_backendに変更があるか確認
if [ -n "$(git diff --cached --name-only errorda2_backend)" ]; then

    echo "新しいブランチを作成し切替"
    git checkout -b "$new_backend_branch"

    echo "errorda2_backendのコミット・プッシュ"
    git commit -m "$backend_commit_message"
    git push origin "$new_backend_branch"

    echo "プルリクエストを作成"
    gh pr create --title "$new_backend_branch" --body "$backend_pr_body" --base main --head "$new_backend_branch"

    echo "元のブランチに戻る"
    git checkout "$current_branch"

    echo "作成したブランチを削除（ローカルでは不要のため）"
    git branch -D "$new_backend_branch"
else
    echo "errorda2_backendに変更はありません"
fi