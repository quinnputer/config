#!/usr/bin/env bash

set -euo pipefail

nix flake check --show-trace --option allow-import-from-derivation false
