#!/bin/bash

bspc subscribe node_add node_remove node_state node_focus desktop_focus | while read; do /home/romensky/.config/bspwm/set_gap.sh; done

