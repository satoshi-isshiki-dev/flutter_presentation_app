# Решение тестового задания (Junior)

Текст Задания:

# Используя сервис https://jsonplaceholder.typicode.com/ реализовать псевдо-приложение/
Список экранов:
- 1. Список пользователей. Вывод списка, полученного по апи в виде карточек вида 
  [
    username
    name
  ]
- 2. Страница пользователя. Подробный вывод информации о пользователе
  [
    в AppBar - username
    (далее по списку)
    name
    email
    phone
    website
    working(company)[
      name
      bs
      catchPhrase (курсив, как цитата)
    ]
    adress
    список из 3-х превью (заголовок, 1 строчка текста...) постов пользователя + возможность посмотреть все (экран 3)
    список из 3-х превью альбомов пользователя с миниатюрой + возможность посмотреть все (экран 4)
  ]
- 3. список постов пользователя. Все посты в формате превью + возможность перейти на детальную (экран 5)
- 4. список альбомов пользователя
- 5. детальная страница поста со списком всех комментариев c именем и email. так же, внизу экрана добавить кнопку добавления комментария. По клику открывается форма с 3 полями имя, email, текс комментария и кнопкой "отправить/send" (на выбор: отдельный экран, модальное окно, bottomSheet). Отправку сделать на тот же сервер и сохранить в SharedPreferences с псевдо-присвоенным id.
- 6. детальная альбома. Все фото альбома с описанием и слайдером
Все полученные данные необходимо кэшировать используя пакет SharedPreferences, и не должны повторно запрашиваться если уже получены.
Требования к внешнему виду: понятный интерфейс на Ваш вкус.


## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
