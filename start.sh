#!/bin/bash
set -e

# Configure runner
./config.sh \
    --unattended \
    --url https://github.com/storce/actions-runner \
    --token $RUNNER_TOKEN \
    --replace --name ocf-github-runner

# Start runner
./run.sh
