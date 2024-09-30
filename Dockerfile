FROM ghcr.io/lix-project/lix:latest AS builder
COPY . /tmp/build
WORKDIR /tmp/build
ENTRYPOINT ["nix", "--extra-experimental-features", "nix-command flakes", "--option", "filter-syscalls", "false", "--log-format", "multiline-with-logs", "build"]