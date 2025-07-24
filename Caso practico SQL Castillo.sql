select * from menu_items;

--Encontrar cuantos articulos hay en el menu--
select count(*) from menu_items; --32

--¿Cuál es el artículo menos caro y el más caro en el menú?--
Select max(price) from menu_items;  --19.95

Select min(price) from menu_items; --5

-- ¿Cuántos platos americanos hay en el menú?
select count(*) from menu_items where category = 'American'; --6

-- ¿Cuál es el precio promedio de los platos?
select round(avg(price),2) from menu_items --13.29

-- PARTE C
--select * from order_details;

--¿Cuántos pedidos únicos se realizaron en total?
Select count(distinct order_id) from order_details; --5370 

-- ¿Cuáles son los 5 pedidos que tuvieron el mayor número de artículos?
--440, 2675, 3473, 4305, 443 con 14 cada uno
select order_id, count(*) as total_de_articulos from order_details 
group by order_id
order by total_de_articulos desc
limit 5;

--¿Cuándo se realizó el primer pedido y el último pedido?
select min(order_date) from order_details; --2023-01-01
select max(order_date) from order_details; --2023-03-31

--¿Cuántos pedidos se hicieron entre el '2023-01-01' y el '2023-01-05'?

Select count(distinct order_id) from order_details 
where order_date between '2023-01-01' and '2023-01-05'; --308

select od.*,mi.* from order_details as od
left join 
menu_items as mi ON od.item_id=mi.menu_item_id;

--Una vez que hayas explorado los datos en las tablas correspondientes y respondido las
--preguntas planteadas, realiza un análisis adicional utilizando este join entre las tablas. El
--objetivo es identificar 5 puntos clave que puedan ser de utilidad para los dueños del
--restaurante en el lanzamiento de su nuevo menú. Para ello, crea tus propias consultas y
--utiliza los resultados obtenidos para llegar a estas conclusiones.

-- 1.- Cuales son las 3 categoría a las que debería prestarse más atención por sus bajos pedidos?
--LAS QUE NO TIENEN CATEGFORIA 137, AMERICANA 2734 Y MEXICANA 2945
Select mi.category, count(*) as pedidos_totales 
from order_details as od
left join 
menu_items as mi ON od.item_id=mi.menu_item_id
group by 1
order by 2 asc
limit 3;

-- 2 Categoría con menos ingresos --Americana $28237
Select mi.category, sum(mi.price)
from order_details as od
left join 
menu_items as mi ON od.item_id=mi.menu_item_id
group by 1
order by 2 asc
limit 1;

--3.- Cantidad de pedidos y su total $ por mes (de mayor a menor)?
--El mes con mayor venta y en ordenes MARZO CON 41186 Y $54610.60
SELECT
    TO_CHAR(order_date, 'MM') AS numero_mes,
    COUNT(*) AS total_ordenes,
	SUM(mi.price) as total_ventas
FROM order_details as od
left join 
menu_items as mi ON od.item_id=mi.menu_item_id
group by 1
order by 3 DESC; 


--4.- CUALES FUERON LOS 3 DIAS CON MÁS INGRESOS del ultimo mes (MARZO)
-- 1. 17 con 2346, 13 con 2251, 27 con 2165
SELECT
	TO_CHAR(order_date, 'DD') AS numero_dia,
	SUM(mi.price) as total_ventas
FROM order_details as od
left join 
menu_items as mi ON od.item_id=mi.menu_item_id
where order_date>= '2023-03-01'
GROUP BY 1
order by 2 DESC
limit 3; 



--5.- Cuáles son los 5 articulos que mas se vendieron después del medio dia?
-- 1Hamburger 596. 2 Edamame 586 3.Cheeseburger 554 4. KoreanBeefBowl552 5. French fires 539 
select mi.item_name, count(*)
from order_details as od
left join 
menu_items as mi ON od.item_id=mi.menu_item_id
where od.order_time>='12:00:00'
group by 1 
order by 2 desc
limit 5;





      









