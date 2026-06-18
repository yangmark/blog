---
title: "HTTPS Server for File Uploading"
summary: "架構一個可斷點續傳、可水平擴展的 HTTPS 檔案上傳系統"
date: 2026-06-16
draft: false
tags: ["https", "file",]
categories: [""]
showTableOfContents: true
---

如何快速架構一個可斷點續傳、可水平擴展的 HTTPS 檔案上傳系統?

在大多數的系統中，「檔案上傳」看似只是一個附屬功能，但是當檔案從數 MB 成長到 GB級別，傳統的 HTTP 上傳開始會出現連線超時、瀏覽器中斷後無法續傳、單機儲存無法擴充、甚至整個服務被大量上傳拖垮。
為了讓檔案上傳服務具備真正的「韌性」，我們必須重新思考這個功能背後的架構設計。

本篇文章分享一個簡單的設計組合，可支援斷點續傳（Resumable Upload）、可水平擴展（Scale-out）、並與後端處理流程整合（Event-driven Processing）的方案。這套高併發、可水平擴展的檔案上傳系統，可以拆成五個主要層級：Nginx、tusd Upload Node、Object Storage、Queue、Post Processor。以下一個一個分析：

### 1️⃣ Nginx / Load Balancer
  - 角色：Reverse Proxy，SSL/TLS termination、權限驗證、流量分流、限速
  - 模組：Nginx

### 2️⃣ Upload Node (tusd)
  - 角色：負責處理檔案上傳、斷點續傳、檔案分片
  - 模組：
    - 官方 "tusd"（Go 實作，開箱即用）
    - https://lnkd.in/e4vcQAeg

### 3️⃣ Object Storage (S3 / MinIO / GCS)
  - 角色：持久化儲存上傳的檔案或檔案片段
  - 模組：
    - AWS S3、GCP Cloud Storage、MinIO（自建相容 S3）
    - 開發階段可以先採用 Local Storage

### 4️⃣ Queue (Kafka / RabbitMQ)
  - 角色：解耦上傳完成事件與後續處理流程
  - 模組：
    - Kafka（高吞吐量、大型分散式系統）
    - RabbitMQ（簡單、可靠、支援延遲隊列）

### 5️⃣ Post Processor
  - 角色：非同步後續處理
  - 模組：
    - 根據團隊使用的程式語言實作
    - 連接 Object Storage 讀檔
    - 處理後更新資料庫或發通知

透過上述的技術棧組合，我們不需要花費太多時間去實作這樣的系統。我們可以把重心擺在收到檔案後，什麼才是我們的產品/服務真正要做的事情！
以上簡單跟大家分享。

#tus #tusd #FileUpload #TUSProtocol