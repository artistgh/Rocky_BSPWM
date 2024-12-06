#!/bin/bash

# Получаем идентификатор текущего рабочего стола
current_desktop=$(bspc query -D -d)

# Устанавливаем символы для активного и неактивного рабочих столов
active_symbol=""   # Символ для активного рабочего стола
inactive_symbol=""  # Символ для неактивного рабочего стола

# Обновляем статус бар (например, i3status, polybar и т.д.)
# Пример с polybar:
# Обновляем имя рабочего стола в polybar
polybar-msg cmd update

# Устанавливаем текущий символ
if [ "$current_desktop" ]; then
    echo "$active_symbol"
else
    echo "$inactive_symbol"
fi
