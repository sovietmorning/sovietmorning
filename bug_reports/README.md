## :lady_beetle: Баг-репорты

В данном разделе представлены баг-репорты, составленные во время прохождения курсов и выполнения заданий на тренажёрах

:red_circle: [**баг-репорты**](https://docs.google.com/spreadsheets/d/1A6wfg81Zt_zzpxmRd97NyGfFdWnH54xEaW5OBwu1tFc/edit?usp=sharing), созданные при тестировании учебного API [restapi.tech](https://restapi.tech/)

:red_circle: **баг-репорты**, созданные в [Jira](https://www.atlassian.com/software/jira) при тестировании учебного API [QA Playground](https://petstore.swagger.io/?url=https://dev-gs.qa-playground.com/api/v1/swagger.json):

- [_JR-01_](screenshots/QAP-1.png) _500 Internal Server Error при DELETE-запросе для удаления пользователя по uuid_
- [_JR-02_](screenshots/QAP-2.png) _Сервер не применяет фильтрацию по query-параметру при GET-запросе на эндпоинт /games/search и возвращает полный список игр_
- [_JR-03_](screenshots/QAP-4.png) _Поле nickname в теле ответа пустое при создании пользователя через POST-запрос на эндпоинт /users_
- [_JR-04_](screenshots/QAP-5.png) _Обновление пользователя уже занятыми данными (nickname, email) происходит без ошибок при PATCH-запросе_
- [_JR-05_](screenshots/QAP-6.png) _При POST-запросе для добавления игры в список желаемого возвращается 422 статус-код и сообщение "Whishlist limit is reached: 10"_

:red_circle: **баг-репорты**, созданные в [YouTrack](https://www.jetbrains.com/ru-ru/youtrack/) при функциональном тестировании [учебной CRM-платформы](https://dev-crm.qa-playground.com/):

- [_YT-01_](screenshots/YT-QAP-1.png) _Контакт не был добавлен в список контактов_
- [_YT-02_](screenshots/YT-QAP-2.png) _После добавления заметки содержимое заметки пустое_
- [_YT-03_](screenshots/YT-QAP-3.png) _Фильтрация по созданному тегу не работает_
- [_YT-04_](screenshots/YT-QAP-4.png) _Функция перетаскивания сделки для изменения статуса не работает_
- [_YT-05_](screenshots/YT-QAP-5.png) _Экспортированный CSV-файл не содержит данных, если отобрано менее 5 контактов_
