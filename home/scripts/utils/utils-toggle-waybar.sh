#!/usr/bin/env bash

# TODO: Add a check for toggle -> Is the service running? True -> Kill, False -> Start
reload_waybar(){
    niri msg action do-screen-transition --delay-ms 200
    systemctl --user restart rh-waybar.service
}

reload_waybar
