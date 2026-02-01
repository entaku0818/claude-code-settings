# Claude Code Settings

このリポジトリは、Claude Codeおよび各プロジェクトで共通に使用するスキル構築のガイドライン・テンプレート・チェックリストを管理するためのものです。

## 📚 ドキュメント

### スキル構築ガイド

[docs/skills/](./docs/skills/) に、Claudeのスキルを構築するための完全なガイドと実用的なリソースが含まれています:

- **完全ガイド (PDF)**: Anthropic公式の「The Complete Guide to Building Skills for Claude」
- **チェックリスト**: スキル作成時の確認項目
- **テンプレート**: すぐに使えるスキルテンプレート

## 🎯 使い方

### 1. スキル構築を始める前に

```bash
# チェックリストを確認
cat docs/skills/checklist.md
```

### 2. テンプレートを使用してスキルを作成

```bash
# テンプレートをプロジェクトにコピー
cp -r docs/skills/templates/skill-template your-project/skills/your-skill-name/
```

### 3. 完全ガイドを参照

PDFまたはMarkdownバージョンを参照して、詳細な実装方法を確認してください。

## 📖 各プロジェクトでの使用方法

このリポジトリは各プロジェクトの共通リファレンスとして機能します:

1. **新しいスキルを作成する時**: テンプレートとチェックリストを使用
2. **スキルのデバッグ時**: トラブルシューティングガイドを参照
3. **ベストプラクティスの確認**: 完全ガイドの該当セクションを確認

## 🔗 関連リソース

- [Anthropic Skills Documentation](https://docs.anthropic.com/claude/docs/skills)
- [MCP Documentation](https://modelcontextprotocol.io/)
- [Claude Developer Discord](https://discord.gg/claude-dev)

## 📝 貢献

このリポジトリに新しいテンプレートやガイドラインを追加する場合は、プルリクエストを作成してください。
