#!/bin/bash

# Быстрая загрузка одной команды

cd "/Users/admin/Desktop/Новая папка" && git add . && git commit -m "Обновление: $(date '+%Y-%m-%d %H:%M:%S')" && git push origin main && echo "✅ Загружено!" || echo "❌ Ошибка!"

