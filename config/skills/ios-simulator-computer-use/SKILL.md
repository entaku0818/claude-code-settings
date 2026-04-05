---
name: ios-simulator-computer-use
description: iOSシミュレーターをコンピューターユースで視覚的にテストします。スクリーンショットを撮影してUI要素を確認し、座標ベースでタップ・スワイプ操作を行いテスト結果を報告します。Use when ユーザーが「シミュレーターでテストして」「iOSシミュレーターを視覚的にテストして」「computer useでシミュレーターを操作して」「シミュレーターの画面確認して」と言ったとき。
---

# iOS Simulator Computer Use テスト

iOSシミュレーターのスクリーンショットを取得し、UIを視覚的に確認しながら操作・テストするスキルです。

## 指示

### Step 1: シミュレーター起動確認

```bash
# 起動中のシミュレーターを確認
xcrun simctl list devices | grep Booted

# シミュレーターが起動していない場合は起動
# UDID は `xcrun simctl list devices | grep iPhone` で確認
xcrun simctl boot <UDID>
open -a Simulator
```

起動確認後、Simulatorアプリが画面に表示されるまで待つ（3〜5秒）。

### Step 2: スクリーンショット撮影・視覚確認

```bash
# スクリーンショットを /tmp に保存
xcrun simctl io booted screenshot /tmp/sim_screenshot.png
```

撮影したスクリーンショット `/tmp/sim_screenshot.png` を Read ツールで読み込み、以下を確認する：

- 現在表示されている画面・アプリ
- タップ可能な主要UI要素とその座標
- テキストフィールド・ボタン・ナビゲーションバーの位置

### Step 3: UI操作（座標ベース）

視覚確認で得た座標を使って操作する：

```bash
# 特定アプリを起動（タップより確実）
xcrun simctl launch booted <BundleID>
# 例: 設定
xcrun simctl launch booted com.apple.Preferences
# 例: Safari
xcrun simctl launch booted com.apple.mobilesafari

# ホームに戻る
xcrun simctl io booted sendkey keycode 0x73 # Home相当（環境依存）
```

**座標タップ（AppleScript経由）:**

スクリーンショット解像度とウィンドウサイズから座標を変換してクリックする。

```python
# 座標変換の計算式
# スクリーンショットサイズ: sips -g pixelWidth -g pixelHeight /tmp/sim_screenshot.png
# ウィンドウ位置・サイズ: osascript -e 'tell app "System Events" to tell process "Simulator" to {position of window 1, size of window 1}'
# → 例: "win_x, win_y, win_w, win_h = 554, 37, 403, 862"
# → 例: "img_w, img_h = 1179, 2556"

x_abs = win_x + int(x_img * win_w / img_w)
y_abs = win_y + int(y_img * win_h / img_h)
```

```bash
# AppleScriptでクリック（Accessibility権限が必要）
osascript -e '
tell application "Simulator" to activate
delay 0.5
tell application "System Events"
  click at {<x_abs>, <y_abs>}
end tell'
```

**注意**: タップより `xcrun simctl launch booted <BundleID>` でのアプリ起動を優先する。UI内のボタンタップはAppleScript経由で行う（Accessibility権限が必要）。

### Step 4: 操作後の確認

```bash
# 操作後にスクリーンショットを再撮影
xcrun simctl io booted screenshot /tmp/sim_after.png
```

Read ツールで `/tmp/sim_after.png` を読み込み、操作結果を確認：

- 期待通りの画面遷移が起きたか
- エラーダイアログが表示されていないか
- UI要素が正しい状態になっているか

### Step 5: テスト結果レポート

以下の形式で結果を報告する：

```
## テスト結果

### 確認した画面
- [スクリーンショットから確認した画面名]

### 実行した操作
1. [操作1] → [結果]
2. [操作2] → [結果]

### 合否
- PASS: [正常に確認できた項目]
- FAIL: [問題が見つかった項目]

### スクリーンショット
- 操作前: /tmp/sim_screenshot.png
- 操作後: /tmp/sim_after.png
```

## 使用例

**ユーザー入力:**
> シミュレーターでホーム画面をテストして

**Claudeの動作:**
1. `xcrun simctl list devices | grep Booted` でシミュレーター確認
2. 未起動なら `xcrun simctl boot <UDID>` で起動
3. `xcrun simctl io booted screenshot /tmp/sim_screenshot.png` でスクリーンショット撮影
4. スクリーンショットを読み込んでUI要素を確認・座標を特定
5. 必要に応じてタップ・スワイプ操作を実行
6. 操作後のスクリーンショットで結果を確認
7. テスト結果を報告

**ユーザー入力:**
> Safariを開いてYahooにアクセスして画面確認して

**Claudeの動作:**
1. `xcrun simctl launch booted com.apple.mobilesafari` でSafari起動
2. スクリーンショットでアドレスバーの座標確認
3. アドレスバーをタップ → URL入力 → 画面確認

## トラブルシューティング

### `No devices are booted` エラー
```bash
# シミュレーターを起動する
xcrun simctl boot BB013E57-C4C4-4FCB-B7A1-BDF7A182739A
open -a Simulator
sleep 3
```

### スクリーンショットが黒い・空白
Simulatorアプリが表示されていない可能性がある。
```bash
open -a Simulator
sleep 2
xcrun simctl io booted screenshot /tmp/sim_screenshot.png
```

### タップが効かない
- 座標がシミュレーターの画面範囲外の可能性あり
- スクリーンショットで正確な座標を再確認する
- iPhone 15 Pro の画面サイズ: 393×852 pt（logical）

### アプリのBundleIDがわからない
```bash
xcrun simctl listapps booted | grep -i <アプリ名>
```
