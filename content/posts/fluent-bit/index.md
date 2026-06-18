---
title: "Fluent Bit"
summary: "Fluent Bit 以「輕量、高效、模組化」著稱，已成為許多大型平台（如 AWS、Google Cloud、Kubernetes）的核心日誌代理"
date: 2026-06-16
draft: false
tags: ["fluentbit", "log", "cloud"]
categories: [""]
showTableOfContents: true
---

為何我很喜歡使用 Fluent Bit 作為日誌處理引擎？

在雲原生與邊緣運算的時代，資料的傳輸效率可以有效提升整個系統的體驗。其中，Fluent Bit 以「輕量、高效、模組化」著稱，已成為許多大型平台（如 AWS、Google Cloud、Kubernetes）的核心日誌代理。底下是我認為高效能的關鍵設計：

1. 用 C 語言實作、極度貼近系統層，幾乎沒有 runtime overhead。記憶體與 CPU 使用量遠低於同類工具（如 Fluentd 或 Logstash）。
2. 事件驅動架構（Event-Driven Architecture），實作了高併發非阻塞 I/O。每個輸入、過濾與輸出插件都以輕量 coroutine 形式運作，避免多執行緒鎖競爭。
3. 零拷貝資料管線（Zero-Copy Pipeline），日誌資料在 Input → Filter → Output 流轉過程中，幾乎不進行額外複製，有效減少 CPU cache miss 與記憶體壓力。
4. 模組化插件系統（Modular Plugin System）分為三大類插件：Input / Filter / Output，各插件可動態載入與配置，適合彈性部署。
5. 針對資源受限環境設計，Binary 體積僅約 **~1MB**，非常適合 IoT、Edge、或容器 sidecar 使用。

我這邊提供幾個使用上的心得：

- “Fluentd” 的社群資源插件雖然非常豐富，但是實際使用的時候，仍然必須逐一驗證可用性。這個過程也需要多次的測試與驗證，相當花費時間。Fluent Bit 的插件雖然相對比較少，但是每一個插件都完整可用，而且有足夠的文件。
- “Logstash” 的優點是非常有彈性，但是資源的消耗也相當的可觀。相較之下使用 Fluent Bit再搭配scale out的成本效益比較高。
- “FileBeat” 有一個非常明顯的缺點，就是只能設定一個輸出插件。資料routing的設計沒有Fluent Bit好用。當我想要設計一個資料的中繼/分派模組，Fluent Bit就相當適合。

總結：

Fluent Bit 的高效能並非僅僅來自「快的程式碼」，而是來自整體設計哲學 - 以最小代價搬運最大資料量。
它不僅是日誌轉送工具，更是現代觀測性架構中的輕量資料匯流的優質選擇。

Fluent Bit官方網站：https://fluentbit.io/

#FluentBit #Observability #CloudNative #Logging #DevOps #EdgeComputing
