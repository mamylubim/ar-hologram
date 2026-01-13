#!/bin/bash

echo "🔐 Настройка SSH ключей для автоматической загрузки на GitHub"
echo ""

# Проверяем есть ли уже SSH ключи
if [ -f ~/.ssh/id_ed25519.pub ] || [ -f ~/.ssh/id_rsa.pub ]; then
    echo "✅ SSH ключи уже существуют!"
    echo ""
    echo "Ваш публичный ключ:"
    if [ -f ~/.ssh/id_ed25519.pub ]; then
        cat ~/.ssh/id_ed25519.pub
    else
        cat ~/.ssh/id_rsa.pub
    fi
    echo ""
    echo "📋 Скопируйте ключ выше и добавьте на GitHub:"
    echo "   1. Зайдите на: https://github.com/settings/keys"
    echo "   2. Нажмите 'New SSH key'"
    echo "   3. Вставьте скопированный ключ"
    echo "   4. Нажмите 'Add SSH key'"
    echo ""
    read -p "Нажмите Enter когда добавите ключ на GitHub..."
else
    echo "📝 Создаю новый SSH ключ..."
    echo ""
    
    # Запрашиваем email
    read -p "Введите ваш email для GitHub: " GITHUB_EMAIL
    
    if [ -z "$GITHUB_EMAIL" ]; then
        GITHUB_EMAIL="mamylubim@users.noreply.github.com"
    fi
    
    # Создаем SSH ключ
    ssh-keygen -t ed25519 -C "$GITHUB_EMAIL" -f ~/.ssh/id_ed25519 -N ""
    
    echo ""
    echo "✅ SSH ключ создан!"
    echo ""
    echo "Ваш публичный ключ:"
    cat ~/.ssh/id_ed25519.pub
    echo ""
    echo "📋 Скопируйте ключ выше и добавьте на GitHub:"
    echo "   1. Зайдите на: https://github.com/settings/keys"
    echo "   2. Нажмите 'New SSH key'"
    echo "   3. Вставьте скопированный ключ"
    echo "   4. Нажмите 'Add SSH key'"
    echo ""
    read -p "Нажмите Enter когда добавите ключ на GitHub..."
fi

# Запускаем ssh-agent
eval "$(ssh-agent -s)" > /dev/null 2>&1

# Добавляем ключ в ssh-agent
if [ -f ~/.ssh/id_ed25519 ]; then
    ssh-add ~/.ssh/id_ed25519 2>/dev/null
else
    ssh-add ~/.ssh/id_rsa 2>/dev/null
fi

# Меняем remote на SSH
cd "/Users/admin/Desktop/Новая папка"
git remote set-url origin git@github.com:mamylubim/ar-hologram.git

echo ""
echo "🔄 Проверяю подключение к GitHub..."
echo ""

# Тестируем подключение
if ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"; then
    echo "✅ SSH ключ успешно настроен!"
    echo ""
    echo "🚀 Теперь можно использовать скрипты для автоматической загрузки:"
    echo "   ./быстрая_загрузка.sh"
    echo ""
else
    echo "⚠️  Не удалось проверить подключение автоматически."
    echo "   Попробуйте вручную: ssh -T git@github.com"
    echo ""
    echo "   Если увидите 'Hi mamylubim! You've successfully authenticated' - все работает!"
    echo ""
fi

