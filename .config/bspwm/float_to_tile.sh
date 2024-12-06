#!/bin/bash

# Получаем идентификатор активного окна
win=$(bspc query -N -n focused)

# Получаем координаты текущего окна (позиция и размер)
win_x=$(bspc query -T -n "$win" | jq '.rectangle.x')
win_y=$(bspc query -T -n "$win" | jq '.rectangle.y')
win_w=$(bspc query -T -n "$win" | jq '.rectangle.width')
win_h=$(bspc query -T -n "$win" | jq '.rectangle.height')

# Получаем все tile-окна на текущем десктопе
tiles=$(bspc query -N -n .tiled)

# Инициализируем переменные для ближайшего окна
closest_tile=""
closest_dist=""

# Функция для вычисления расстояния между двумя точками
distance() {
    echo "sqrt(($1 - $2) ^ 2 + ($3 - $4) ^ 2)" | bc
}

# Проходим по всем tile-окнам и находим ближайшее
for tile in $tiles; do
    tile_x=$(bspc query -T -n "$tile" | jq '.rectangle.x')
    tile_y=$(bspc query -T -n "$tile" | jq '.rectangle.y')
    dist=$(distance "$win_x" "$tile_x" "$win_y" "$tile_y")

    if [ -z "$closest_dist" ] || (( $(echo "$dist < $closest_dist" | bc -l) )); then
        closest_dist="$dist"
        closest_tile="$tile"
    fi
done

# Перемещаем окно в найденный tile-сегмент
if [ -n "$closest_tile" ]; then
    bspc node "$win" -n "$closest_tile" -t tiled
fi

