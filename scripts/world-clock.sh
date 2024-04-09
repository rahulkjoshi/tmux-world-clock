#! /usr/bin/env bash
# vi: ft=bash

function main() {
    local tz_csv
    IFS="," tz_csv=( $( tmux show -gqv "@world_clock_tzs" ) ); unset IFS;

    local main_style=$( tmux show -gqv "@world_clock_main_style" )
    local sec_style=$( tmux show -gqv "@world_clock_sec_style" )
    local date_fmt=$( tmux show -gqv "@world_clock_date_fmt" )
    if [[ -n "${date_fmt}" ]]; then
        date_fmt=" ${date_fmt}"
    fi
    local time_fmt=$( tmux show -gqv "@world_clock_time_fmt" )

    local is_first=true
    for tz in "${tz_csv[@]}"; do
        if [[ "$is_first" == true ]]; then
            printf "${main_style:-#[fg=default]}"
        else
            printf "#[fg=default] | ${sec_style:-#[fg=default]}"
        fi

        local t=$( TZ="${tz}" date +"${time_fmt}${date_fmt}" )
        printf "${t}"

        if [[ "$is_first" == true ]]; then
            is_first=false
            date_fmt=""
        fi
    done
    printf "#[fg=default]"
}

main
