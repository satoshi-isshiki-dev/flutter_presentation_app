# Решение тестового задания (Junior)

- 1 Экран списка пользователей (здесь можно менять цветовую тему и отображение сетки)
- 2 Экран пользователя (+ список постов, список альбомов, Экран поста (+ загрузка и добавление комментариев), принцип работы "кэширования"
- 3 Экран Альбома, слайдер, принцип работы "кэширования"
- 4 Обработка ситуации "отключения интернета"

1 ![](intro.gif)
2 ![](posts.gif)
***
3 ![](albums.gif)
4 ![](network.gif)

- UI часть накидана очень быстро (чтобы можно было, потыкать и проверить функционал), без особого дизайна.


# Текст Задания:
Используя сервис https://jsonplaceholder.typicode.com/ реализовать псевдо-приложение
***
Список экранов:
1. Список пользователей. Вывод списка, полученного по апи в виде карточек вида 
  [
    username
    name
  ]
2. Страница пользователя. Подробный вывод информации о пользователе
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
3. список постов пользователя. Все посты в формате превью + возможность перейти на детальную (экран 5)
4. список альбомов пользователя
5. детальная страница поста со списком всех комментариев c именем и email. так же, внизу экрана добавить кнопку добавления комментария. По клику открывается форма с 3 полями имя, email, текс комментария и кнопкой "отправить/send" (на выбор: отдельный экран, модальное окно, bottomSheet). Отправку сделать на тот же сервер и сохранить в SharedPreferences с псевдо-присвоенным id.
6. детальная альбома. Все фото альбома с описанием и слайдером
Все полученные данные необходимо кэшировать используя пакет SharedPreferences, и не должны повторно запрашиваться если уже получены.
Требования к внешнему виду: понятный интерфейс на Ваш вкус.


