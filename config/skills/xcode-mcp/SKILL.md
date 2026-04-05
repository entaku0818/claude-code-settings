---
name: xcode-mcp
description: Xcode MCP（mcpbridge）を Claude Code に追加します。Use when ユーザーが「Xcode MCP入れて」「シミュレーター操作できるようにして」「mcpbridge設定して」と言ったとき。
---

# Xcode MCP セットアップ

Xcode 26.3 以降に内蔵された MCP サーバー（mcpbridge）を Claude Code に登録するスキルです。
シミュレーターのタップ・スクロール・スクリーンショット撮影、ビルド・テスト実行などが MCP 経由でできるようになります。

## 参考

- [Apple 公式ドキュメント](https://developer.apple.com/documentation/xcode/giving-agentic-coding-tools-access-to-xcode)
- 必要要件: Xcode 26.3 以上

## 手順

### Step 1: Xcode のバージョン確認

```bash
xcodebuild -version
```

期待される出力: `Xcode 26.3` 以上であること

### Step 2: mcpbridge の存在確認

```bash
xcrun mcpbridge --help 2>&1 | head -5
```

エラーが出る場合は Xcode 26.3 以上をインストール。

### Step 3: プロジェクトスコープに追加

現在のプロジェクトのみで使う場合:

```bash
claude mcp add --transport stdio xcode -- xcrun mcpbridge
```

### Step 4: ユーザースコープに追加（全プロジェクト共通）

すべてのプロジェクトで使う場合:

```bash
claude mcp add --transport stdio --scope user xcode -- xcrun mcpbridge
```

### Step 5: 追加確認

```bash
claude mcp list
```

`xcode` が表示されれば成功。

### Step 6: Claude Code を再起動

設定を反映するため、Claude Code を再起動する。
再起動後、`/mcp` コマンドで xcode サーバーが表示されれば利用可能。

---

## 主な機能

再起動後に使えるようになる主なツール:

- **シミュレーター操作**: タップ・スワイプ・テキスト入力
- **スクリーンショット**: シミュレーター画面をキャプチャ
- **ビルド**: xcodebuild ラッパー
- **テスト実行**
- **SwiftUI Preview キャプチャ**
- **Apple ドキュメント検索**

---

## トラブルシューティング

### `xcrun: error: unable to find utility "mcpbridge"`

Xcode 26.3 未満。Xcode をアップデートするか、Xcode の選択を確認:

```bash
sudo xcode-select -s /Applications/Xcode26.3.app/Contents/Developer
```

### 再起動後も `/mcp` に表示されない

`claude mcp list` で登録を確認し、なければ再度 `claude mcp add` を実行。
