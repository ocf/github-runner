FROM debian:12-slim

ARG RUNNER_VERSION="2.328.0"
ARG RUNNER_TOKEN="AQQ6ABTWMDZN3J6X52NWFYTI3JBDY"
ENV DEBIA_FRONTEND=noninteractive
ENV RUNNER_TOKEN=${RUNNER_TOKEN}

WORKDIR /runner

RUN apt update -y && apt install -y curl

RUN curl -o actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

RUN tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

RUN ls
RUN pwd

RUN /runner/bin/installdependencies.sh

RUN useradd -m docker
RUN chown -R docker /runner

# Runner config commands cannot be run by root
USER docker

RUN ./config.sh \
    --unattended \
    --url https://github.com/storce/actions-runner \
    --token ${RUNNER_TOKEN} \
    --replace --name emp
CMD ["./run.sh"]
