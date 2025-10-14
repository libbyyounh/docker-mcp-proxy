# file: mcp-proxy.Dockerfile

FROM ghcr.io/sparfenyuk/mcp-proxy:latest

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
    
RUN apk add --update --no-cache \
    --repository https://mirrors.aliyun.com/alpine/v3.22/main/ \
    --repository https://mirrors.aliyun.com/alpine/v3.22/community/ \
    --repository https://mirrors.aliyun.com/alpine/edge/community/ \
    --repository https://mirrors.aliyun.com/alpine/edge/main/ \
    nodejs=22.19.0-r3 npm=11.6.1-r0

ENV UV_INDEX_URL="https://mirrors.aliyun.com/pypi/simple/"
ENV PIP_INDEX_URL="https://mirrors.aliyun.com/pypi/simple/"

# Install the 'uv' package
RUN python3 -m ensurepip && pip install --no-cache-dir uv

ENV PATH="/usr/local/bin:$PATH" \
    UV_PYTHON_PREFERENCE=only-system

ENTRYPOINT ["catatonit", "--", "mcp-proxy"]
