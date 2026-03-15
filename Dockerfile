# 1. Базовый образ
FROM python:3.9-slim

# 2. Рабочая директория
WORKDIR /app

# 3. Установка системных пакетов
RUN apt-get update && apt-get install -y \
    curl \
    vim \
    && rm -rf /var/lib/apt/lists/*

# 4. Установка Python-пакетов
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 5. Копируем код приложения
COPY app.py .

# 6. Создаём пользователя
RUN useradd -m -u 1000 appuser

# 7. Переключаемся на пользователя
USER appuser

# 8. Открываем порт
EXPOSE 5000

# 9. Переменная окружения
ENV FLASK_ENV=production

# 10. Запуск приложения
CMD ["python", "app.py"]
