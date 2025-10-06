#!/bin/bash
set -e

# Configure runner
./config.sh \
    --unattended \
    --url https://github.com/ocf \
    --pat ${GITHUB_PAT} \
    --replace --name ocf-github-runner

# Start runner
./run.sh
