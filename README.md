# Document_app

Приложение представляет собой хранилище документов с сохранением истории его изменений (включая файлы).

В приложении представлен следующий функционал:
1. Создание документа
2. Редактирование существующего документа
3. Поиск документа
4. Просмотр истории изменения документа (включая файлы)
5. Заполнение и редактирование  справочников

# Установка

Установите необходимые гемы и зависимости:

```
bundle install
yarn
```

Выполните установку dartsass-rails окружения:

```
bin/rails dartsass:install
```

Настройте базу данных:

```
bin/rails db:create
bin/rails db:migrate
```


Запуск сервера:

```
bin/dev
```
