alter table PROJECT.CAFE
add constraint CAFE_pk primary key(CAFE_NAME);

alter table PROJECT.CUSTOMER
add constraint CUSTOMER_pk primary key(CUSTOMER_ID);

alter table PROJECT.WAITER
add constraint WAITER_pk
primary key(WAITER_ID);
alter table PROJECT.WAITER
add constraint WAITER_fk Foreign key(CAFE_NAME)
references PROJECT.CAFE(CAFE_NAME);
	
alter table PROJECT. MEAL
add constraint MEAL_pk
primary key(MEAL_ID)
constraint MEAL_fk foreign key(WAITER_id)
references PRODUCT.WAITER(WAITER_ID);

alter table PROJECT.CHEF
add constraint CHEF_pk primary key(CHEF_ID);

alter table PROJECT.ORDERS
add constraint ORDERS_pk primary key(ORDERS_ID);
alter table PROJECT.ORDERS
add constraint ORDERS_fk foreign key(CUSTOMER_ID)
references PROJET.CUSTOMER(CUSTOMER_ID);
alter table PROJECT.ORDERS
add constraint ORDERS_CHEF_fk foreign key(CHEF_ID)
references PROJECT.CHEF(CHEF_ID);
alter table PROJECT.ORDERS
add constraint ORDERS_ck check(ORDERS_DATE<GETDATE());

SELECT ORDER_ID, CUSTOMER.CUSTOMER_NAME,ORDERS_DATE
     FROM orders
    INNER JOIN CUSTOMER ON orders.order_id=customer.customer_id;
    
    SELECT Customer.customer_name, MEAL.meal_id
FROM Customer
LEFT JOIN meal ON Customer.customer_id = meal.meal_id
ORDER BY Customer.customer_name;

SELECT Orders.order_id, waiter.waiter_name
FROM Orders
RIGHT JOIN waiter ON Orders.order_id = Waiter.waiter_ID
ORDER BY Orders.order_id;

SELECT Customer.customer_name, Orders.order_id
FROM Customer
FULL OUTER JOIN Orders ON Customer.customer_id=orders.order_id
ORDER BY Customer.customer_name;
SELECT S.customer_name AS customer_name1, E.customer_name AS customer_name2, S.customer_address
FROM Customer S, Customer E
WHERE S.customer_id <> E.customer_id
AND s.customer_address = e.customer_address 
ORDER BY S.customer_address;

SELECT * FROM CHEF CROSS JOIN MEAL
WHERE CHEF.CHEF_id =68;

SELECT MEAL_TAX FROM MEAL
UNION
SELECT ORDER_TOTALPRICE FROM orders;

SELECT MEAL_TAX FROM MEAL
UNION ALL
SELECT ORDER_TOTALPRICE FROM orders;

SELECT  waiter_hiredate FROM waiter
WHERE waiter_hiredate='16-03-17'
UNION ALL
SELECT chef_hiredate FROM Chef
WHERE chef_hiredate='16-04-24'
ORDER BY waiter_hiredate;

SELECT COUNT(CAFE_id), CAFE_address
FROM CAFE
GROUP BY CAFE_address
ORDER BY COUNT(CAFE_id) DESC;

SELECT COUNT(customer_id), customer_address
FROM customer
GROUP BY customer_address
HAVING COUNT(customer_id) < 5;

SELECT DISTINCT CHEF_NAME , CHEF_SALARY
FROM CHEF;

SELECT CUSTOMER_ID , CUSTOMER_NAME 
FROM CUSTOMER
WHERE customer_phone IS NOT NULL;

SELECT CUSTOMER_ID , CUSTOMER_NAME, customer_address 
FROM CUSTOMER
WHERE customer_phone IS NULL;

SELECT WAITER_ID , WAITER_NAME 
FROM WAITER
WHERE waiter_name LIKE 'K%';

SELECT MEAL_ID , MEAL_NAME , MEAL_PRICE 
FROM MEAL
ORDER BY meal_name;

SELECT CHEF_ID AS "CHEF", 
UPPER(CHEF_NAME) AS "COOK NAME"
FROM CHEF;

SELECT SUM(MEAL_TAX) AS "TAX ON TOTAL MEALS"
FROM MEAL;

SELECT WAITER_ID , WAITER_NAME , WAITER_SALARY
FROM WAITER 
WHERE WAITER_SALARY > 5500;

SELECT DISTINCT C.CUSTOMER_NAME 
FROM CUSTOMER C
INNER JOIN 
ORDERS O
ON C.CUSTOMER_ID != O.ORDER_ID;

SELECT CHEF_NAME AS "COOK DETAIL"
FROM CHEF C 
WHERE EXISTS (SELECT * FROM orders O 
                WHERE c.chef_HIREDATE = o.orders_date);

SELECT CHEF_NAME AS "COOK DETAIL"
FROM CHEF C 
WHERE NOT EXISTS (SELECT * FROM orders O 
                WHERE c.chef_HIREDATE = o.orders_date);