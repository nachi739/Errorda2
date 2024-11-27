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
flag_repo_url=$(get_submodule_repo_url "flag_checker")

# 最新コミットメッセージを取得
chrome_commit_message=$(cd chrome_extensions && git log -1 --pretty=%B)
# コミットメッセージ内容
chrome_commit_message="submodule_chrome:$chrome_commit_message"
# 新しいブランチ名
new_chrome_branch="dev-chrome_extensions-$(date +%Y%m%d%H)"
# プルリクエストリンクを取得
chrome_pr_link=$(get_submodule_latest_closed_pr_link "$chrome_repo_url")
# PRの本文
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

# 最新コミットメッセージを取得
flag_commit_message=$(cd flag_checker && git log -1 --pretty=%B)
# コミットメッセージ内容
flag_commit_message="submodule_flag:$flag_commit_message"
# 新しいブランチ名
new_flag_branch="dev-errorda2_flag_checker-$(date +%Y%m%d%H)"
# プルリクエストリンクを取得
flag_pr_link=$(get_submodule_latest_closed_pr_link "$flag_repo_url")
# PRの本文
flag_pr_body=$(echo -e "## やったこと
\n- サブモジュールの更新内容の反映
\n## なぜやるのか・背景
\n- 修正や追加機能があったため、それらをプロジェクト内に反映する必要があるため
\n## 動作確認
\n- サブモジュール側で実施済み
\n## Refs
\n- 対象のサブモジュールのPull requestのリンク
\n$flag_pr_link")

# --ここからerrorda2_flag_checkerの処理--
echo "flag_checkerの変更をステージング(対象以外を含まないために)"
git add flag_checker/

# errorda2_flag_checkerに変更があるか確認
if [ -n "$(git diff --cached --name-only flag_checker)" ]; then

    echo "新しいブランチを作成し切替"
    git checkout -b "$new_flag_branch"

    echo "flag_checkerのコミット・プッシュ"
    git commit -m "$flag_commit_message"
    git push origin "$new_flag_branch"

    echo "プルリクエストを作成"
    gh pr create --title "$new_flag_branch" --body "$flag_pr_body" --base main --head "$new_flag_branch"

    echo "元のブランチに戻る"
    git checkout "$current_branch"

    echo "作成したブランチを削除（ローカルでは不要のため）"
    git branch -D "$new_flag_branch"
else
    echo "flag_checkerに変更はありません"
fi