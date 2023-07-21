#!/bin/sh

docker compose -f ssh.yml up -d && \
ssh -D 1024 test@localhost