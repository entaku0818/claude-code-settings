# cmux スクリプト

cmux用のセットアップスクリプト集。

## ファイル構成

```
cmux/
├── README.md       # このファイル
├── cmux-repos      # repository配下を全ワークスペースで開く
└── cmux-setup      # ワークスペースのレイアウト自動セットアップ（yazi + lazygit）
```

## セットアップ

### 1. スクリプトを ~/bin/ にコピー

```bash
cp cmux-repos cmux-setup ~/bin/
chmod +x ~/bin/cmux-repos ~/bin/cmux-setup
```

### 2. ~/bin/ にPATHが通っているか確認

```bash
echo $PATH | grep -o "$HOME/bin"
```

通っていない場合は `~/.zshrc` に追記：

```zsh
export PATH="$HOME/bin:$PATH"
```

### 3. cmux起動時に自動でセットアップするよう ~/.zshrc に追記

```zsh
# cmux起動時に自動でレイアウトをセットアップ
if [ -n "$CMUX_WORKSPACE" ]; then
    _CMUX_SOCK_ID=$(stat -f "%i" /tmp/cmux.sock 2>/dev/null)
    _CMUX_FLAG="/tmp/cmux-layout-done-${_CMUX_SOCK_ID}"
    if [ ! -f "$_CMUX_FLAG" ]; then
        touch "$_CMUX_FLAG"
        (sleep 1 && cmux-setup "$PWD" > /dev/null 2>&1) &
    fi
    unset _CMUX_SOCK_ID _CMUX_FLAG
fi
```

## 使い方

### repository配下を全て開く

cmuxを起動した状態でターミナルから実行：

```bash
cmux-repos
```

`/Users/entaku/repository` 配下のディレクトリが全てワークスペースとして開く。

### レイアウトのセットアップ

任意のワークスペースで実行（引数なしで現在のディレクトリを使用）：

```bash
cmux-setup                        # 現在のディレクトリ
cmux-setup /path/to/project       # パス指定
```

実行すると以下のレイアウトが作られる：

```
┌─────────┬──────────────┐
│         │              │
│  yazi   │  ターミナル   │
│         │              │
│         ├──────────────┤
│         │   lazygit    │
└─────────┴──────────────┘
```
