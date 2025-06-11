FROM ubuntu:focal

RUN \
    rm -f /etc/apt/apt.conf.d/docker-clean && \
    echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > \
    /etc/apt/apt.conf.d/01keep-debs

RUN \
    apt update && \
    apt --no-install-recommends -y \
        install gcc

RUN \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    --mount=type=cache,target=/var/cache/apt,sharing=locked \
    ls -la /var/cache/apt/archives
