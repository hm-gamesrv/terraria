# =================
# 资源下载
# =================
FROM alpine:3 AS downloader

RUN apk add --no-cache \
    wget \
    unzip

WORKDIR /downloads
RUN wget https://www.terraria.org/api/download/pc-dedicated-server/terraria-server-1456.zip
RUN unzip ./terraria-server-1456.zip

# ===================
# 主镜像
# ===================
FROM debian:trixie-slim

ENV TZ=Asia/Shanghai

RUN groupadd -g 1000 gamesrv && \
    useradd -u 1000 -g gamesrv -m -s /bin/bash gamesrv
RUN mkdir -p /app && chown 1000:1000 /app

COPY --from=downloader --chown=1000:1000 ["/downloads/1456/Linux", "/app"]
COPY --chown=1000:1000 ["./patch/", "/app"]
RUN chmod +x /app/TerrariaServer && \
    chmod +x /app/TerrariaServer.bin.x86_64

EXPOSE 7777/tcp

VOLUME [ "/app/world" ]

WORKDIR /app
USER 1000:1000
CMD ["bash", "/app/start-server.sh"]