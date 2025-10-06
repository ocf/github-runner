FROM theocf/debian:bookworm

ARG RUNNER_VERSION="2.328.0"

WORKDIR /runner
COPY start.sh .

RUN apt update -y && apt install -y \
	curl \
	python3 \
	pipx \
	mariadb-server \
    git

RUN curl -o actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

RUN tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

RUN /runner/bin/installdependencies.sh

# Setup script for groups and users to accommodate some of ocflib's tests 
COPY setup_user.sh .
RUN ./setup_user.sh

# Runner config commands cannot be run by root
RUN useradd -m ocf 
RUN chown -R ocf /runner
USER ocf 

# Since the server is run by a different user, we must install pipx packages under user ocf
RUN pipx install poetry
ENV PATH="/home/ocf/.local/bin:${PATH}"


CMD ["./start.sh"]
