# =================
# 资源下载
# =================
FROM alpine:latest AS downloader

RUN apk add --no-cache \
    wget \
    unzip

WORKDIR /downloads
RUN wget https://www.terraria.org/api/download/pc-dedicated-server/terraria-server-1456.zip
RUN unzip ./terraria-server-1456.zip

# ===================
# 基座镜像
# ===================
FROM debian:trixie-slim

EXPOSE 7777/tcp

VOLUME [ "/app/world" ]

ENV TZ=Asia/Shanghai

RUN groupadd -g 1000 gamesrv && \
    useradd -u 1000 -g gamesrv -m -s /bin/bash gamesrv
RUN mkdir -p /app && chown 1000:1000 /app
USER 1000:1000

COPY --from=downloader --chown=1000:1000 ["/downloads/1456/Linux", "/app"]
RUN chmod +x /app/TerrariaServer
RUN chmod +x /app/TerrariaServer.bin.x86_64
COPY --chown=1000:1000 ["./patch/", "/app"]

WORKDIR /app

CMD ["bash", "/app/start-server.sh"]