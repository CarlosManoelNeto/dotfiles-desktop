#!/bin/bash

grim -g "$(slurp)" - | satty \
    --filename - \
    --copy-command "wl-copy"