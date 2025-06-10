/* Задача №1: Посчитать, сколько раз была заказана каждая книга, для книги вывести ее автора 
(нужно посчитать, в каком количестве заказов фигурирует каждая книга).  
Вывести фамилию и инициалы автора, название книги, последний столбец назвать "Количество". 
Результат отсортировать сначала  по фамилиям авторов, а потом по названиям книг.*/

    SELECT  name_author, 
            title, 
            COUNT(buy_id) AS Количество
      FROM  buy_book
RIGHT JOIN  book 
        ON  buy_book.book_id = book.book_id
      JOIN  author
        ON  author.author_id = book.author_id
  GROUP BY  buy_book.book_id, 
            book.title, 
            author.author_id
  ORDER BY  name_author ASC, 
            title ASC;
            

/* Задача №2: Вывести информацию о каждом заказе: его номер, кто его сформировал (фамилия пользователя) 
и его стоимость (сумма произведений количества заказанных книг и их цены), 
в отсортированном по номеру заказа виде. Последний столбец назвать Стоимость.*/

  SELECT  b.buy_id,
          c.name_client,
          SUM(bb.amount * bk.price) AS Стоимость
    FROM  client c
    JOIN  buy b 
      ON  c.client_id = b.client_id
    JOIN  buy_book bb 
      ON  b.buy_id = bb.buy_id
    JOIN  book bk 
      ON  bb.book_id = bk.book_id
GROUP BY  buy_id
ORDER BY  b.buy_id ASC;


/* Задача №3: В таблице city для каждого города указано количество дней, 
за которые заказ может быть доставлен в этот город (рассматривается только этап "Транспортировка"). 
Для тех заказов, которые прошли этап транспортировки, вывести количество 
дней за которое заказ реально доставлен в город. А также, если заказ доставлен с опозданием, 
указать количество дней задержки, в противном случае вывести 0. 
В результат включить номер заказа (buy_id), 
а также вычисляемые столбцы Количество_дней и Опоздание. 
Информацию вывести в отсортированном по номеру заказа виде.*/

SELECT  bs.buy_id, 
        DATEDIFF(date_step_end, date_step_beg) AS Количество_дней, 
        IF(DATEDIFF(date_step_end, date_step_beg) > c.days_delivery, 
        DATEDIFF(date_step_end, date_step_beg) - c.days_delivery, 0) AS Опоздание
  FROM  buy_step bs
  JOIN  buy b 
 USING  (buy_id)
  JOIN  client cl 
 USING  (client_id)
  JOIN  city c 
 USING  (city_id)
 WHERE  bs.step_id = 3 
   AND  bs.date_step_beg IS NOT NULL 
   AND  bs.date_step_end IS NOT NULL;
   

/* Задача №4: Вывести жанр (или жанры), в котором было заказано больше всего экземпляров книг, 
указать это количество . Последний столбец назвать Количество. */

  SELECT name_genre, SUM(b_b.amount) AS Количество
    FROM genre g
    JOIN book b 
   USING (genre_id)
    JOIN buy_book b_b 
   USING (book_id)
GROUP BY genre_id
  HAVING Количество = 
         (SELECT MAX(sum_amount) AS max_sum_amount
            FROM 
                  (SELECT b.genre_id, SUM(b_b.amount) AS sum_amount
                     FROM buy_book b_b
                     JOIN book b 
                    USING (book_id)
                     JOIN genre g 
                    USING (genre_id)
                 GROUP BY genre_id) 
			  query_in);
              
            
/* Задача №5: Выбрать всех клиентов, которые заказывали книги Достоевского, 
информацию вывести в отсортированном по алфавиту виде. 
В решении используйте фамилию автора, а не его id. */           

SELECT DISTINCT  name_client
           FROM  client
           JOIN  buy 
          USING  (client_id)
           JOIN  buy_book 
          USING  (buy_id)
           JOIN  book 
          USING  (book_id)
           JOIN  author 
          USING  (author_id)
          WHERE  name_author = "Достоевский Ф.М."
       ORDER BY  name_client ASC;