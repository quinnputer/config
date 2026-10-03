#!/usr/bin/env bash

set -euo pipefail

cog verify --file "$1"
cog check
