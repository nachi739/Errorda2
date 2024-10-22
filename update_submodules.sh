#!/bin/bash

# サブモジュールの更新
git submodule update --remote

# サブモジュールの変更をステージング
git add chrome_extensions/
git add errorda2_backend/

# コミットメッセージ
commit_message="[update] submodules: chrome_extensions and errorda2_backend"

# コミット
git commit -m "$commit_message"

# プッシュ
git push origin main