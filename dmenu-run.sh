#!/bin/bash

# Путь к вашему файлу со списком
LIST=~/.config/dmenu-run_apps


# Проверка существования файла
if [ ! -f "$LIST" ]; then
  echo "Список приложений ($LIST) не найден!"
  exit 1
fi

# Отображение списка псевдонимов в dmenu и выбор
CHOICE=$(cut -d '|' -f1 "$LIST" | dmenu -i -p "RUN:")

# Если выбор сделан, находим соответствующую команду
if [ -n "$CHOICE" ]; then
  CMD=$(grep "^$CHOICE|" "$LIST" | cut -d '|' -f2-)
  # Если команда найдена, запускаем её
  if [ -n "$CMD" ]; then
    bash -c "$CMD" &
  else
    echo "Команда для '$CHOICE' не найдена!"
  fi
fi
