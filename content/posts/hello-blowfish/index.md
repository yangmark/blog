---
title: "Hello, Blowfish！"
summary: "第一篇範例文章，介紹這個部落格框架的結構與使用方式。"
date: 2026-06-16
draft: false
tags: ["hugo", "blowfish", "github-pages"]
categories: ["教學"]
showTableOfContents: true
---

歡迎使用這個 **Hugo + Blowfish** 部落格框架！

## 專案結構

```text
.
├── config/_default/     # Hugo 與 Blowfish 設定
├── content/             # Markdown 文章與頁面
│   ├── _index.md        # 首頁
│   ├── about.md         # 關於頁
│   └── posts/           # 部落格文章
├── assets/img/          # 圖片（作者頭像等）
├── archetypes/          # 新文章範本
└── .github/workflows/   # GitHub Actions 部署
```

## 撰寫新文章

在 `content/posts/` 建立新資料夾，例如 `my-new-post/index.md`：

```bash
hugo new posts/my-new-post/index.md
```

或使用專案內建的腳本：

```bash
./scripts/new-post.sh "我的文章標題"
```

## Front Matter 常用欄位

| 欄位 | 說明 |
|------|------|
| `title` | 文章標題 |
| `summary` | 摘要（列表頁顯示） |
| `date` | 發布日期 |
| `draft` | `true` 時不會發布 |
| `tags` | 標籤陣列 |
| `categories` | 分類陣列 |
| `showTableOfContents` | 顯示目錄 |

## 特色圖片

在文章資料夾放入以 `feature` 開頭的圖片（如 `feature.jpg`），Blowfish 會自動用作縮圖與社群分享預覽圖。

## 本地預覽

```bash
hugo server -D
```

瀏覽 [http://localhost:1313](http://localhost:1313) 即可預覽。

## 部署

Push 到 `main` 分支後，GitHub Actions 會自動建置並部署到 GitHub Pages。

更多說明請參閱專案根目錄的 `README.md`。
