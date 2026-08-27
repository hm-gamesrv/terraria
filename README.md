# Terraria Server / T-Shock Server

## 1. 简述

泰拉瑞亚原版服务器 / T-Shock 插件服务器

**可用版本：**

| 游戏模式         | 镜像 tag         |
| ---------------- | ---------------- |
| 原版服最新正式版 | `1.4.5.8`        |
| 插件服最新正式版 | `tshock-1.4.5.6` |

## 2. 资源占用信息

### 2.1. 端口

| 端口号 | 协议 | 说明         |
| ------ | ---- | ------------ |
| 7777   | TCP  | 游戏联机端口 |

### 2.2. 持久卷

原版服：

| 容器路径     | 说明         |
| ------------ | ------------ |
| `/app/world` | 游戏世界存档 |

插件服：

| 容器路径      | 说明              |
| ------------- | ----------------- |
| `/app/tshock` | TShock 配置与存档 |

## 3. 构建与运行

### 3.1. 构建并运行（Docker）

原版服：

```bash
docker build -t terraria:temp . && \
    docker run --rm -it \
        -p 7777:7777/tcp \
        -v ./world:/app/world \
        terraria:temp
```

插件服：

```bash
docker build -t terraria:tshock-temp . && \
    docker run --rm -it \
        -p 7777:7777/tcp \
        -v ./tshock:/app/tshock \
        terraria:tshock-temp
```

### 3.2. 运行服务器（Podman）

原版服：

```bash
IMAGE=ghcr.io/hm-gamesrv/terraria:latest

if ! podman pull "$IMAGE"; then
    exit 1
fi

podman run --rm -it \
    --name terraria \
    --userns keep-id \
    --network pasta \
    -p 7777:7777/tcp \
    -v ./world:/app/world \
    "$IMAGE"
```

插件服：

```bash
IMAGE=ghcr.io/hm-gamesrv/terraria:tshock-latest

if ! podman pull "$IMAGE"; then
    exit 1
fi

podman run --rm -it \
    --name terraria-tshock \
    --userns keep-id \
    --network pasta \
    -p 7777:7777/tcp \
    -v ./tshock:/app/tshock \
    "$IMAGE"
```

## 4. 其他

- 首次启动会自动创建中型世界（`autocreate=2`），对于 T-Shock 插件服则同时生成 TShock 配置
- 服务器参数见 `*/patch/server.config`（世界路径、难度、最大人数、端口等）
