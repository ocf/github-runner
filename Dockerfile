FROM theocf/debian:bookworm

ENV RUNNER_TOKEN=""
ARG RUNNER_VERSION="2.328.0"

WORKDIR /runner
COPY start.sh .

RUN apt update -y && apt install -y curl python3

RUN curl -o actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

RUN tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

RUN /runner/bin/installdependencies.sh

# Runner config commands cannot be run by root
RUN useradd -m docker
RUN chown -R docker /runner
USER docker

CMD ["./start.sh"]
