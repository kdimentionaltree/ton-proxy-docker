FROM ubuntu:20.04 as builder

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata

RUN apt install -y build-essential cmake clang openssl libssl-dev zlib1g-dev gperf wget git curl libreadline-dev ccache libmicrohttpd-dev

# build tonlib
WORKDIR /

# remove /tree/<commit> to build master branch
ARG TON_REPO_BRANCH=master
RUN echo "Branch: ${TON_REPO_BRANCH}" && \
    git clone --recurse-submodules https://github.com/ton-blockchain/ton.git && \
    cd /ton && git checkout ${TON_REPO_BRANCH}    

# fix lib version and patch logging
WORKDIR /ton
RUN mkdir /ton/build
WORKDIR /ton/build
ENV CC clang
ENV CXX clang++
RUN cmake -DCMAKE_BUILD_TYPE=Release ..
RUN cmake --build . -j$(nproc) --target rldp-http-proxy generate-random-id


FROM ubuntu:20.04

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata

RUN apt install -y openssl libssl-dev wget curl libatomic1 zlib1g-dev gperf wget git curl libreadline-dev ccache libmicrohttpd-dev
WORKDIR /app

COPY --from=builder /ton/build/rldp-http-proxy/rldp-http-proxy /app/rldp-http-proxy
COPY --from=builder /ton/build/utils/generate-random-id /app/generate-random-id
RUN chmod +x /app/rldp-http-proxy && chmod +x /app/generate-random-id
COPY entrypoint.sh /app
COPY generate_adnl.sh /app
ENTRYPOINT [ "/bin/bash" ]
