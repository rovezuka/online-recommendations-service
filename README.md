# Backend для сервиса «Онлайн рекомендации»

Микросервис на Ruby, который предоставляет возможность пользователям (пациентам) отправлять запросы на консультацию с медицинскими специалистами и получать рекомендации на основе анализа их медицинских данных, полученных из внешнего API.

## Функционал

+ Отправка запросов на консультацию
+ Получение и анализ медицинских данных из внешнего API 3. Формирование и отправка рекомендаций пациентам

## Что было создано

### Модели

- Пациент (ФИО, дата рождения, номер телефона, email)

- Запрос на консультацию (пациент, текст запроса, дата создания) 

- Рекомендация (запрос на консультацию, текст рекомендации)

### Endpoints

- POST /consultation_requests - создание запроса на консультацию

- POST /consultation_requests/:request_id/recommendations - создание рекомендации для конкретного запроса на консультацию

- GET /patients/:patient_id/recommendations - получение списка рекомендаций для конкретного пациента

### API

Интегрирован внешний API для анализа медицинских данных (OpenFDA).

### Database

PostgreSQL:  1.1

### Библиотеки

dry-rb: валидация данных при помощи 'dry-validation'

## Начало работы

Эти инструкции помогут вам создать копию проекта и запустить его на вашей локальной машине.

### Предварительные условия

Что нужно установить, чтобы запустить проект:

- ruby "3.2.2"

- rails "7.0.8"

- PostgreSQL

- dry-rb


### Установка

Пошаговая инструкция о том, как получить копию проекта и запустить ее на вашей локальной машине.

1. Клонируйте репозиторий:
```
git clone https://github.com/rovezuka/online-recommendations-service
```

2. Перейдите в каталог проекта:
```
cd online-recommendations-service
```

3. Установите зависимости:
```
bundle install
```

4. Создайте базу данных и выполните миграции:
```
rails db:create
rails db:migrate
```

5. Запустите локальный сервер:
```
rails server
```

## Использование

Как создать нового пациента:
```
# Использовать rails console
Patient.create(full_name: 'Иван Иванов', date_of_birth: '1990-01-01', phone_number: '123-456-7890', email: 'ivan@example.com')
```

### Примеры запросов для каждого из эндпоинтов в Postman:

#### POST /consultation_requests - создание запроса на консультацию

Запрос:

Тип запроса: POST
URL: http://localhost:3000/consultation_requests 

Content-Type: application/json

Body (raw JSON):
```
{
  "patient_id": 1,
  "text": "Прошу консультацию по моему состоянию."
}
```

#### POST /consultation_requests/:request_id/recommendations - создание рекомендации для конкретного запроса на консультацию

Запрос:

Тип запроса: POST

URL: http://localhost:3000/consultation_requests/1/recommendations (где 1 - ID запроса на консультацию, который вы хотите обновить)

Content-Type: application/json

#### GET /patients/:patient_id/recommendations - получение списка рекомендаций для конкретного пациента
Запрос:

Тип запроса: GET

URL: http://localhost:3000/patients/1/recommendations (где 1 - ID пациента, для которого вы хотите получить рекомендации)

## Лицензия
Этот проект лицензирован в соответствии с лицензией MIT - подробности см. в файле LICENSE.md.
