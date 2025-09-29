FROM debian:13-slim

ARG RUNNER_VERSION="2.328.0"
ARG TOKEN=""

WORKDIR /runner

RUN apt update && apt install curl

RUN curl -o actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

RUN tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

RUN ./config.sh \
    --unattended \
    --url https://github.com/storce/actions-runner \
    --token ${RUNNER_TOKEN} \
    --replace --name emp
