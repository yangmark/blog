---
title: "Clean Shutdown Containers"
summary: "When running applications inside Docker, you might notice that containers don’t always stop immediately"
date: 2026-06-16
draft: false
tags: ["container", "tini",]
categories: [""]
showTableOfContents: true
---

### Clean Shutdown Containers

When running applications inside Docker, you might notice that containers don’t always stop immediately or cleanly when you run `docker stop` or `docker-compose down`. The container can hang for several seconds, or your app might terminate abruptly without finishing its cleanup tasks.

Why containers don’t always stop cleanly? When stopping a container, Docker sends a ‘SIGTERM’ signal to the main process (`PID 1`) inside the container. If the process ignores this signal or doesn’t forward it to its child processes, Docker waits 10 seconds (by default), then sends **SIGKILL** to stop it forcefully.
The root cause is that 'PID 1' inside containers doesn’t automatically handle signals or clean up zombie processes like a normal Linux init system.

This can lead to:
- Incomplete cleanup (e.g., unsaved data, unfinished I/O)
- Zombie processes (`defunct`)
- Longer container shutdowns

So far, I have often used `tini` for reliable container shutdowns. `tini` is a tiny init system built for containers. It acts as PID 1, forwards all signals to your real application, and reaps zombie processes automatically.
here is the tini github: https://lnkd.in/gBy6tsYq

Dockerfile example:
``` dockerfile
FROM alpine:3.20
RUN apk add --no-cache tini
# ...
# using tini as entrypoint
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["./myapp"]
```

### Simple conclusion: 

A clean container shutdown requires:
- Signal handling inside your application, and
- Proper PID 1 behavior inside the container.

The simplest and most reliable way to achieve both is to run your app under `tini`.

#docker #tini #containers #CleanShutdown #GracefulShutdown