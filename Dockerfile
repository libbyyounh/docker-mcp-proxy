# file: mcp-proxy.Dockerfile

FROM ghcr.io/sparfenyuk/mcp-proxy:latest

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
    
# 1. 强制重置仓库源，确保只从 v3.21（或 v3.22）获取，避免 edge 仓库的干扰
# 2. 不指定具体的 -rX 修订号，让 apk 自动匹配兼容版本
RUN echo "https://mirrors.aliyun.com/alpine/v3.21/main/" > /etc/apk/repositories && \
    echo "https://mirrors.aliyun.com/alpine/v3.21/community/" >> /etc/apk/repositories && \
    apk add --update --no-cache "nodejs>=22" "npm>=10"

ENV UV_INDEX_URL="https://mirrors.aliyun.com/pypi/simple/"
ENV PIP_INDEX_URL="https://mirrors.aliyun.com/pypi/simple/"

# Install the 'uv' package
RUN python3 -m ensurepip && pip install --no-cache-dir uv

ENV PATH="/usr/local/bin:$PATH" \
    UV_PYTHON_PREFERENCE=only-system

ENTRYPOINT ["catatonit", "--", "mcp-proxy"]
