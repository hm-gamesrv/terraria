# =================
# 资源下载
# =================
FROM alpine:3 AS downloader

RUN apk add --no-cache \
    wget \
    unzip

WORKDIR /downloads
RUN wget -q https://github.com/Pryaxis/TShock/releases/download/v6.1.0/TShock-6.1.0-for-Terraria-1.4.5.6-linux-x64-Release.zip \
    && unzip ./TShock-6.1.0-for-Terraria-1.4.5.6-linux-x64-Release.zip \
    && tar -xf TShock-Beta-linux-x64-Release.tar -C /downloads \
    && rm -rf TShock-6.1.0-for-Terraria-1.4.5.6-linux-x64-Release.zip \
    && rm -rf TShock-Beta-linux-x64-Release.tar

# ===================
# 主镜像
# ===================
FROM mcr.microsoft.com/dotnet/runtime:9.0

RUN groupadd -g 1000 gamesrv \
    && useradd -u 1000 -g gamesrv -m -s /bin/bash gamesrv
RUN mkdir -p /app && chown 1000:1000 /app

COPY --from=downloader --chown=1000:1000 ["/downloads","/app"]
COPY --chown=1000:1000 ./patch/ /app/
EXPOSE 7777/tcp

VOLUME [ "/app/tshock" ]

WORKDIR /app
USER 1000:1000
CMD ["bash", "/app/start-server.sh"]
