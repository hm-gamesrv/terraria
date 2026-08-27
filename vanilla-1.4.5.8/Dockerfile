# =================
# 资源下载
# =================
FROM alpine:3 AS download

RUN apk add --no-cache \
    wget \
    unzip

WORKDIR /download
RUN wget -q https://www.terraria.org/api/download/pc-dedicated-server/terraria-server-1458.zip \
    && unzip ./terraria-server-1458.zip \
    && rm -rf ./terraria-server-1458.zip
RUN chmod +x ./1458/Linux/TerrariaServer \
    && chmod +x ./1458/Linux/TerrariaServer.bin.x86_64

# ===================
# 主镜像
# ===================
FROM debian:trixie-slim

ENV TZ=Asia/Shanghai

RUN groupadd -g 1000 gamesrv \
    && useradd -u 1000 -g gamesrv -m -s /bin/bash gamesrv
RUN mkdir -p /app/world && chown 1000:1000 /app/world

COPY --from=download --chown=1000:1000 ["/download/1458/Linux", "/app"]
COPY --chown=1000:1000 ["./patch/", "/app"]

EXPOSE 7777/tcp

VOLUME [ "/app/world" ]

WORKDIR /app
USER 1000:1000
CMD ["bash", "/app/start-server.sh"]
