#!/bin/bash

set -euo pipefail

# コマンドの種類を取得(例: apply, plan, fmt...)
type=$(echo "$@" |  awk '{print $1}')

# 実行しているディレクトリ名を取得
current_dir=$(pwd | sed 's/.*\///g')

if [ "$type" == "plan" ]; then
    # planのときは-patchオプションを付ける
    # 実行ディレクトリ名をターゲットとして指定
    tfcmt -var "target:${current_dir}" plan -patch -- terraform "$@"
elif [ "$type" == "apply" ]; then
    tfcmt -var "target:${current_dir}" apply -- terraform "$@"
else
    terraform "$@"
fi
