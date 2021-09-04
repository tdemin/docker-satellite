#!/usr/bin/env bash

git clone ${REPOSITORY} /tmp/repo
cd /tmp/repo
TAG="$(git tag | sort -V | tail -1)"
echo "::set-output name=tag::${TAG}"
