#!/bin/zsh
# このリポジトリの設定ファイルを ~/.config にシンボリックリンクで適用する

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_DIR="$REPO_DIR/config"

echo "設定ファイルをセットアップ中..."

link() {
    local src="$1"
    local dst="$2"
    mkdir -p "$(dirname "$dst")"
    ln -sf "$src" "$dst"
    echo "✅ $dst -> $src"
}

# yazi
link "$CONFIG_DIR/yazi/yazi.toml" "$HOME/.config/yazi/yazi.toml"

echo "完了！"
