FROM zmkfirmware/zmk-build-arm:stable as base

RUN apt update && apt install -y software-properties-common jq
RUN add-apt-repository ppa:rmescandon/yq && apt update && apt install -y yq

FROM base AS init
WORKDIR /workspace
COPY build.yaml /workspace/
COPY config/west.yml /workspace/config/
RUN west init -l config && \
    west update && \
    west zephyr-export

FROM init AS build
COPY . /workspace
RUN bash /workspace/docker-build-sh
