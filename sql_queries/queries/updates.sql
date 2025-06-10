/* Обратиться к БД violations*/
USE violations;

/* Задача №1: Занести в таблицу fine суммы штрафов, которые должен оплатить водитель, 
в соответствии с данными из таблицы traffic_violation. 
Суммы занести только в пустые поля столбца sum_fine.*/

UPDATE fine f, 
       traffic_violation tv 
   SET f.sum_fine = tv.sum_fine
 WHERE f.violation = tv.violation 
   AND f.sum_fine IS NULL;

/* Задача №2: Вывести фамилию, номер машины и нарушение только для тех водителей, 
которые на одной машине нарушили одно и то же правило два и более раз. 
Учитывать все нарушения, независимо от того, оплачены они или нет. 
Данные отсортировать в алфавитном порядке, сначала по фамилии водителя, 
потом по номеру машины и, наконец, по нарушению.*/

  SELECT  name, 
          number_plate, 
          violation
    FROM  fine
GROUP BY  name, 
          number_plate, 
          violation
  HAVING  COUNT(number_plate) >= 2
ORDER BY  name ASC, 
          number_plate ASC, 
          violation ASC;

/* Задача №3: В таблице fine увеличить в два раза сумму неоплаченных штрафов
для отобранных на предыдущем шаге записей. */

UPDATE fine, 
       (SELECT name, 
               number_plate, 
               violation
          FROM fine
      GROUP BY name, 
               number_plate, 
               violation
        HAVING COUNT(number_plate) >= 2) AS query_in
   SET fine.sum_fine = fine.sum_fine * 2
 WHERE fine.violation = query_in.violation
   AND fine.number_plate = query_in.number_plate 
   AND date_payment IS NULL;   
    
/* Задача №4: В таблицу fine занести дату оплаты соответствующего штрафа из таблицы payment; 
уменьшить начисленный штраф в таблице fine в два раза (только для тех штрафов, 
информация о которых занесена в таблицу payment), если оплата произведена не позднее 20 дней со дня нарушения.*/

UPDATE fine f, 
       payment p
   SET f.date_payment = p.date_payment,
       f.sum_fine = IF(DATEDIFF(p.date_payment, p.date_violation) < 21, f.sum_fine/2, f.sum_fine) 
 WHERE f.number_plate = p.number_plate
   AND f.violation = p.violation
   AND f.name = p.name
   AND f.date_violation = p.date_violation
   AND f.date_payment IS NULL;       
    
/* Задача №5: Создать новую таблицу back_payment, куда внести информацию о неоплаченных штрафах 
(Фамилию и инициалы водителя, номер машины, нарушение, сумму штрафа  и  дату нарушения) из таблицы fine.*/

CREATE TABLE back_payment AS
      SELECT name, 
             number_plate, 
             violation, 
             sum_fine, 
             date_violation
        FROM fine
       WHERE date_payment IS NULL;

/* Задача №6: Удалить из таблицы fine информацию о нарушениях, совершенных раньше 1 февраля 2020 года. */

DELETE FROM fine
      WHERE date_violation < "2020-02-01";