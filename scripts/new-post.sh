#!/usr/bin/env bash
set -euo pipefail

if [ $# -lt 1 ]; then
  echo "用法: $0 \"文章標題\""
  echo "範例: $0 \"我的第一篇文章\""
  exit 1
fi

TITLE="$1"
SLUG=$(echo "$TITLE" | iconv -f UTF-8 -t ASCII//TRANSLIT 2>/dev/null | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-|-$//g')

if [ -z "$SLUG" ]; then
  SLUG="new-post-$(date +%Y%m%d)"
fi

POST_DIR="content/posts/${SLUG}"
mkdir -p "$POST_DIR"

DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ" 2>/dev/null || date -u +"%Y-%m-%dT%H:%M:%S+00:00")

cat > "${POST_DIR}/index.md" <<EOF
---
title: "${TITLE}"
summary: ""
date: ${DATE}
draft: true
tags: []
categories: []
showTableOfContents: true
---

在這裡開始撰寫文章內容。
EOF

echo "已建立: ${POST_DIR}/index.md"
