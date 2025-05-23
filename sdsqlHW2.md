# Домашнее задание к занятию «Работа с данными (DDL/DML)»

---

### Задание 1
1.1. Поднимите чистый инстанс MySQL версии 8.0+. Можно использовать локальный сервер или контейнер Docker.

1.2. Создайте учётную запись sys_temp. 

1.3. Выполните запрос на получение списка пользователей в базе данных.

![изображение](https://github.com/user-attachments/assets/1b483d3a-6e34-4f55-81c3-8c685352e8aa)

1.4. Дайте все права для пользователя sys_temp. 

1.5. Выполните запрос на получение списка прав для пользователя sys_temp.

![изображение](https://github.com/user-attachments/assets/de15beab-ec10-44bb-a721-90b340422a6f)

1.6. Переподключитесь к базе данных от имени sys_temp с sha2: с версии 9.0 плагин mysql_native_password удален, использую новый sha256_password.
```
ALTER USER 'sys_temp' IDENTIFIED WITH sha256_password BY 'password';
```

1.6. По ссылке https://downloads.mysql.com/docs/sakila-db.zip скачайте дамп базы данных.

1.7. Восстановите дамп в базу данных.

1.8. При работе в IDE сформируйте ER-диаграмму получившейся базы данных. При работе в командной строке используйте команду для получения всех таблиц базы данных.

![изображение](https://github.com/user-attachments/assets/90103334-977f-4089-b297-b4c49ac7a72c)

![изображение](https://github.com/user-attachments/assets/e92cbe23-4013-40bb-bf58-162f94855e38)

### Задание 2
Составьте таблицу, используя любой текстовый редактор или Excel, в которой должно быть два столбца: в первом должны быть названия таблиц восстановленной базы, во втором названия первичных ключей этих таблиц.

<img width="387" alt="изображение" src="https://github.com/user-attachments/assets/0c02488a-8d3c-420e-9b5e-ebecca94ce03" />

## Дополнительные задания (со звёздочкой*)
Эти задания дополнительные, то есть не обязательные к выполнению, и никак не повлияют на получение вами зачёта по этому домашнему заданию. Вы можете их выполнить, если хотите глубже шире разобраться в материале.

### Задание 3*
3.1. Уберите у пользователя sys_temp права на внесение, изменение и удаление данных из базы sakila.

3.2. Выполните запрос на получение списка прав для пользователя sys_temp. (скриншот)

![изображение](https://github.com/user-attachments/assets/edb46b03-2778-45e8-9cfa-79c365e2f858)
