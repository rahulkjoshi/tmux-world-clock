#! /usr/bin/env bash
#! vi: ft=bash

function main() {
    local tz_csv
    # shellcheck disable=SC2207 # IFS set correctly
    IFS="," tz_csv=( $( tmux show -gqv "@world_clock_tzs" ) ); unset IFS;

    local pri_style
    pri_style=$( tmux show -gqv "@world_clock_pri_style" )
    pri_style="${pri_style:-#[default]}"
    local sec_style
    sec_style=$( tmux show -gqv "@world_clock_sec_style" )
    sec_style="${sec_style:-#[default]}"
    local date_style
    date_style=$( tmux show -gqv "@world_clock_date_style" )
    date_style="${date_style:-#[default]}"

    local date_fmt
    date_fmt=$( tmux show -gqv "@world_clock_date_fmt" )
    local time_fmt
    time_fmt=$( tmux show -gqv "@world_clock_time_fmt" )

    local pri_sep
    pri_sep=$( tmux show -gqv "@world_clock_pri_sep" )
    pri_sep="${pri_sep:-#[default]|}"
    local time_sep
    time_sep=$( tmux show -gqv "@world_clock_time_sep" )
    time_sep="${time_sep:-#[default]|}"
    local date_sep
    date_sep=$( tmux show -gqv "@world_clock_date_sep" )
    date_sep="${date_sep:-#[default]|}"

    local last_idx=$(( ${#tz_csv[@]}-1 ))
    for i in "${!tz_csv[@]}"; do
        tz="${tz_csv[$i]}"
        if (( i == 0 )); then
            echo -n "${pri_style} "
        else
            echo -n "${sec_style} "
        fi

        echo -n "$( TZ="${tz}" date +"${time_fmt} " )"

        if (( i == 0 )); then
            echo -n "${pri_sep}"
        elif (( i != last_idx )); then
            echo -n "${time_sep}"
        fi
    done
    echo -n  "${date_sep}${date_style} "
    echo -n "$( TZ="${tz}" date +"${date_fmt} " )"
    echo -n "#[default]"
}

main
