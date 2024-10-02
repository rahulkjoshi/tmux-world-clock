#! /usr/bin/env bash
#! vi: ft=bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SCRIPT="${CURRENT_DIR}/scripts/world-clock.sh"

function main() {
    local status_left
    status_left="$( tmux show -gqv "status-left" | sed 's!#{world_clock}!#('"${SCRIPT}"')!' )"
    tmux set -gq "status-left" "${status_left}"

    local status_right
    status_right="$( tmux show -gqv "status-right" | sed 's!#{world_clock}!#('"${SCRIPT}"')!' )"
    tmux set -gq "status-right" "${status_right}"
}

main
