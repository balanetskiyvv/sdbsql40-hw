# Домашнее задание к занятию «SQL. Часть 2»

### Задание 1

Одним запросом получите информацию о магазине, в котором обслуживается более 300 покупателей, и выведите в результат следующую информацию: 
- фамилия и имя сотрудника из этого магазина;
- город нахождения магазина;
- количество пользователей, закреплённых в этом магазине.

```SQL
SELECT CONCAT(s.first_name, ' ', s.last_name) AS Name, c.city, COUNT(cu.customer_id) AS Quantity
FROM staff s
JOIN address a ON a.address_id = s.address_id
JOIN city c ON c.city_id = a.city_id
JOIN store st ON st.store_id = s.store_id
JOIN customer cu ON cu.store_id = st.store_id
GROUP BY s.first_name, s.last_name, c.city
HAVING Quantity > 300;
```

![изображение](https://github.com/user-attachments/assets/3aade578-039c-4d96-9bd5-39c9b5c21749)

### Задание 2

Получите количество фильмов, продолжительность которых больше средней продолжительности всех фильмов.

```SQL
SELECT COUNT(length)
FROM film
WHERE length > (SELECT AVG(length) FROM film);
```

![изображение](https://github.com/user-attachments/assets/b73dd7d6-d174-4999-a494-c996c3a9d328)

### Задание 3

Получите информацию, за какой месяц была получена наибольшая сумма платежей, и добавьте информацию по количеству аренд за этот месяц.

```SQL
SELECT DATE_FORMAT(payment_date, '%M-%Y') AS Date, SUM(amount) AS Total_amount, COUNT(rental_id) as Rentals
FROM payment
GROUP BY Date
ORDER BY Total_amount DESC
LIMIT 1;
```

![изображение](https://github.com/user-attachments/assets/965a8ed8-019f-4516-a24b-1c043849a3ef)

### Задание 4*

Посчитайте количество продаж, выполненных каждым продавцом. Добавьте вычисляемую колонку «Премия». Если количество продаж превышает 8000, то значение в колонке будет «Да», иначе должно быть значение «Нет».

```SQL
SELECT staff_id, COUNT(rental_id) AS Sales,
	CASE 
		WHEN COUNT(rental_id) > 8000 THEN "Yes"
		ELSE "No"
	END	AS Bonus
FROM rental
GROUP BY staff_id;
```

![изображение](https://github.com/user-attachments/assets/0ccc5f0c-cd8f-49d5-895c-bf9dd7c75a51)

### Задание 5*

Найдите фильмы, которые ни разу не брали в аренду.

```SQL
SELECT f.film_id, f.title
FROM film f
WHERE f.film_id NOT IN (
    SELECT i.film_id
    FROM inventory i
    JOIN rental r ON r.inventory_id = i.inventory_id
);
```

![изображение](https://github.com/user-attachments/assets/57603e4a-0861-4ab5-8a9c-1d72fbf6dc11)
