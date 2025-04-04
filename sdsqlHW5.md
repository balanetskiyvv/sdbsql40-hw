# Домашнее задание к занятию «Индексы»

### Задание 1

Напишите запрос к учебной базе данных, который вернёт процентное отношение общего размера всех индексов к общему размеру всех таблиц.

```SQL
SELECT ROUND((SUM(index_length) / SUM(data_length+index_length)) * 100, 2)
FROM information_schema.TABLES
WHERE table_schema = 'sakila';
```

![изображение](https://github.com/user-attachments/assets/93ddcd79-c4a0-411a-91ee-4dcee6f801aa)

### Задание 2

Выполните explain analyze следующего запроса:
```sql
select distinct concat(c.last_name, ' ', c.first_name), sum(p.amount) over (partition by c.customer_id, f.title)
from payment p, rental r, customer c, inventory i, film f
where date(p.payment_date) = '2005-07-30' and p.payment_date = r.rental_date and r.customer_id = c.customer_id and i.inventory_id = r.inventory_id
```
- перечислите узкие места;
- оптимизируйте запрос: внесите корректировки по использованию операторов, при необходимости добавьте индексы.

Ответ: После анализа исходного запроса было выявлено, что оконная функция обрабатывает излишние таблицы, а именно, rental, inventory и film. По сути, нужно определить сумму платежей каждого клиента на определенную дату. Поэтому, ранее указанные таблицы бесполезны, т.к. не представляются в итоговом виде.

Оптимизируем:
```SQL
select distinct concat(c.last_name, ' ', c.first_name), sum(p.amount) over (partition by c.customer_id)
from payment p, customer c
where date(p.payment_date) = '2005-07-30' and p.customer_id = c.customer_id;
```

Actual time до = 3934, после = 14, в итоге оптимизация обработки запроса повысилась в 281 раз.

ДО:  
![изображение](https://github.com/user-attachments/assets/c6196f9d-cd54-477d-82f1-fc1573ac8fb1)

ПОСЛЕ:  
![изображение](https://github.com/user-attachments/assets/baf0afb3-c473-4d32-ad46-405e2283285f)

### Задание 3*

Самостоятельно изучите, какие типы индексов используются в PostgreSQL. Перечислите те индексы, которые используются в PostgreSQL, а в MySQL — нет.

1. В PostgreSQL используются следующие типы индексов:
*  B-дерево (B-tree) - самый распространенный тип, подходит для запросов на равенство и диапазон;
*  Хэш-индексы - используются для простого сравнения на равенство;
*  GiST (Generalized Search Tree) - гибкий формат для пользовательских типов данных и сложных запросов;
*  GIN (Generalized Inverted Index) - для индексации составных значений (массивы, полнотекстовый поиск);
*  BRIN (Block Range Index) - эффективен для больших таблиц с естественной сортировкой;
*  SP-GiST (Space Partitioned GiST) - оптимизирован для данных с пространственным разделением.
2. Индексы, которые есть в PostgreSQL, но отсутствуют в MySQL:
* GiST (Generalized Search Tree);
* GIN (Generalized Inverted Index);
* BRIN (Block Range Index);
* SP-GiST (Space Partitioned GiST).

Хэш-индексы и B-деревья присутствуют в обеих СУБД, хотя их реализация может отличаться. Уникальной особенностью PostgreSQL является более широкий выбор типов индексов, особенно для сложных запросов и нестандартных типов данных.
