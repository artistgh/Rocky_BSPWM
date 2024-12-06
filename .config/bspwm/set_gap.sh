#!/bin/bash

# Получаем идентификатор текущего рабочего стола
current_desktop=$(bspc query -D -d)

# Получаем количество окон на текущем рабочем столе, которые находятся в тайловом режиме
tile_windows_count=$(bspc query -N -d $current_desktop -n .tiled | wc -l)

# Получаем количество окон на текущем рабочем столе, которые находятся в плавающем режиме
floating_windows_count=$(bspc query -N -d $current_desktop -n .floating | wc -l)

if [ "$tile_windows_count" -eq 1 ]; then
    # Если есть одно тайловое окно
    bspc config window_gap 0  # значение для одного окна
    bspc config border_width 0
elif [ "$tile_windows_count" -eq 0 ] && [ "$floating_windows_count" -gt 0 ]; then
    # Если нет тайловых окон, но есть плавающие
    bspc config window_gap 8  # значение для нескольких окон
    bspc config border_width 4
elif [ "$tile_windows_count" -gt 1 ]; then
    # Если есть несколько тайловых окон
    bspc config window_gap 8  # значение для нескольких окон
    bspc config border_width 4
else
    # Если вообще нет окон, настройки для одного окна
    bspc config window_gap 0
    bspc config border_width 0
fi
