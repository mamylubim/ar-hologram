#!/bin/bash

echo "🚀 Загрузка AR приложения на GitHub Pages"
echo ""
echo "⚠️  ВАЖНО: Сначала создайте репозиторий на GitHub!"
echo "   1. Зайдите на https://github.com"
echo "   2. Нажмите 'New' → создайте репозиторий 'ar-hologram'"
echo "   3. НЕ добавляйте README, .gitignore и т.д."
echo ""
read -p "Введите ваш GitHub username: " GITHUB_USERNAME
read -p "Введите название репозитория (или нажмите Enter для 'ar-hologram'): " REPO_NAME

if [ -z "$REPO_NAME" ]; then
    REPO_NAME="ar-hologram"
fi

echo ""
echo "📤 Загружаю файлы на GitHub..."
echo ""

cd "/Users/admin/Desktop/Новая папка"

# Добавляем remote
git remote remove origin 2>/dev/null
git remote add origin "https://github.com/$GITHUB_USERNAME/$REPO_NAME.git"

# Переименовываем ветку в main
git branch -M main

# Загружаем файлы
git push -u origin main

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Файлы успешно загружены!"
    echo ""
    echo "📋 Теперь включите GitHub Pages:"
    echo "   1. Зайдите на: https://github.com/$GITHUB_USERNAME/$REPO_NAME"
    echo "   2. Settings → Pages"
    echo "   3. Source: Branch 'main', Folder '/ (root)'"
    echo "   4. Save"
    echo ""
    echo "🌐 Ваш сайт будет доступен по адресу:"
    echo "   https://$GITHUB_USERNAME.github.io/$REPO_NAME/index-arjs.html"
    echo ""
else
    echo ""
    echo "❌ Ошибка при загрузке. Проверьте:"
    echo "   - Создан ли репозиторий на GitHub"
    echo "   - Правильно ли указан username"
    echo "   - Есть ли доступ к интернету"
    echo ""
fi

