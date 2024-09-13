#! /usr/bin/env bash
#! vi: ft=bash

function main() {
    local tz_csv
    IFS="," tz_csv=( $( tmux show -gqv "@world_clock_tzs" ) ); unset IFS;

    local default_style="#[fg=default bg=default]"

    local pri_style=$( tmux show -gqv "@world_clock_pri_style" )
    pri_style="${pri_style:-${default_style}}"
    local sec_style=$( tmux show -gqv "@world_clock_sec_style" )
    sec_style="${sec_style:-${default_style}}"
    local date_style=$( tmux show -gqv "@world_clock_date_style" )
    date_style="${date_style:-${default_style}}"

    local date_fmt=$( tmux show -gqv "@world_clock_date_fmt" )
    local time_fmt=$( tmux show -gqv "@world_clock_time_fmt" )

    local is_first=true
    for tz in "${tz_csv[@]}"; do
        if [[ "$is_first" == true ]]; then
            printf "${pri_style}"
            is_first=false
        else
            printf "#[fg=default] | ${sec_style}"
        fi

        printf "$( TZ="${tz}" date +"${time_fmt}" )"
    done
    printf  "#[fg=default] | ${date_style}"
    printf "$( TZ="${tz}" date +"${date_fmt}" )"
    printf "${default_style}"
}

main
