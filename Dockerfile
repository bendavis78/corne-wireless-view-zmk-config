FROM zmkfirmware/zmk-build-arm:stable AS base

RUN apt update && apt install -y software-properties-common jq curl
RUN curl -sL https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -o /usr/bin/yq && \
    chmod +x /usr/bin/yq

FROM base AS west
WORKDIR /workspace
COPY build.yaml /workspace/
COPY config/west.yml /workspace/config/
RUN west init -l config && \
    west update && \
    west zephyr-export

FROM west AS build
COPY . /workspace
ENTRYPOINT ["bash", "/workspace/docker-build-sh"]
CMD []
