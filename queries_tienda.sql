-- 1. List the name of all products in the product table.
SELECT nombre FROM producto;
-- 2. List the names and prices of all products in the product table.
SELECT nombre, precio FROM producto;
-- 3. List all columns from the product table.
SELECT * FROM producto;
-- 4. List the product names, price in euros and price in US dollars (USD).
SELECT nombre, precio, precio * 1.08 AS precio_usd FROM producto;
-- 5. List the product names, price in euros and price in US dollars (USD). Using column aliases: product name, euros, dollars.
SELECT nombre AS 'product name', precio AS euros, precio * 1.08 AS dollars FROM producto;
-- 6. List the names and prices of all products in the product table, converting names to uppercase.
SELECT UPPER(nombre), precio FROM producto;
-- 7. List the names and prices of all products in the product table, converting names to lowercase.
SELECT LOWER(nombre), precio FROM producto;
-- 8. List all manufacturers names in one column, and capitalize first two characters in another column.
SELECT nombre, UPPER(LEFT(nombre, 2)) AS initials FROM fabricante;
-- 9. List the names and prices of all products in the product table, rounding the price value.
SELECT nombre, ROUND(precio) AS rounded_price FROM producto;
-- 10. List the names and prices of all products in the product table, truncating the price to no decimals.
SELECT nombre, TRUNCATE(precio, 0) AS price_no_decimals FROM producto;
-- 11. List the codes of manufacturers that have products in the product table.
SELECT DISTINCT codigo_fabricante FROM producto;
-- 12. List the codes of manufacturers that have products, eliminating duplicate codes.
SELECT DISTINCT codigo_fabricante FROM producto;
-- 13. List manufacturer names in ascending order.
SELECT nombre FROM fabricante ORDER BY nombre;
-- 14. List manufacturer names in descending order.
SELECT nombre FROM fabricante ORDER BY nombre DESC;
-- 15. List product names sorted by name ascending and price descending.
SELECT nombre, precio FROM producto ORDER BY nombre ASC, precio DESC;
-- 16. Return a list with the first 5 rows of the manufacturer table.
SELECT * FROM fabricante LIMIT 5;
-- 17. Return a list with 2 rows starting from the fourth row of manufacturer table.
SELECT * FROM fabricante LIMIT 2 OFFSET 3;
-- 18. List the name and price of the cheapest product (using ORDER BY and LIMIT).
SELECT nombre, precio FROM producto ORDER BY precio ASC LIMIT 1;
-- 19. List the name and price of the most expensive product (using ORDER BY and LIMIT).
SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;
-- 20. List the name of all products from manufacturer with code equal to 2.
SELECT nombre FROM producto WHERE codigo_fabricante = 2;
-- 21. Return a list with product name, price and manufacturer name of all products.
SELECT p.nombre AS "Product Name", p.precio, f.nombre AS "Manufacturer Name" FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo;
-- 22. Return a list with product name, price and manufacturer name, sorted by manufacturer name.
SELECT p.nombre AS "Product Name", p.precio, f.nombre AS "Manufacturer Name" FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo ORDER BY f.nombre ASC;
-- 23. Return a list with product code, product name, manufacturer code and manufacturer name.
SELECT p.codigo AS "Product Code", p.nombre AS "Product Name", f.codigo AS "Manufacturer Code", f.nombre AS "Manufacturer Name" FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo;
-- 24. Return product name, price and manufacturer name of the cheapest product.
SELECT p.nombre AS "Product Name", p.precio, f.nombre AS "Manufacturer Name" FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo ORDER BY p.precio ASC LIMIT 1;
-- 25. Return product name, price and manufacturer name of the most expensive product.
SELECT p.nombre AS "Product Name", p.precio, f.nombre AS "Manufacturer Name" FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo ORDER BY p.precio DESC LIMIT 1;
-- 26. Return a list of all products from manufacturer Lenovo.
SELECT p.nombre AS "Product Name", p.precio FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Lenovo';
-- 27. Return a list of all products from manufacturer Crucial with price greater than €200.
SELECT p.nombre AS "Product Name", p.precio, f.nombre AS "Manufacturer Name" FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Crucial' AND p.precio > 200;
-- 28. Return a list with all products from manufacturers Asus, Hewlett-Packard and Seagate (without IN operator).
SELECT p.nombre AS "Product Name", f.nombre AS "Manufacturer Name" FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Asus' OR f.nombre = 'Hewlett-Packard' OR f.nombre = 'Seagate';
-- 29. Return a list with all products from manufacturers Asus, Hewlett-Packard and Seagate (using IN operator).
SELECT p.nombre AS "Product Name", f.nombre AS "Manufacturer Name" FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre IN ('Asus', 'Hewlett-Packard', 'Seagate');
-- 30. Return a list with name and price of all products from manufacturers whose name ends with vowel e.
SELECT p.nombre AS "Product Name", p.precio, f.nombre AS "Manufacturer Name" FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE LOWER(f.nombre) LIKE '%e';
-- 31. Return a list with name and price of all products whose manufacturer name contains character w.
SELECT p.nombre AS "Product Name", p.precio, f.nombre AS "Manufacturer Name" FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE LOWER(f.nombre) LIKE '%w%';
-- 32. Return a list with product name, price and manufacturer name of products with price >= €180, sorted by price desc and name asc.
SELECT p.nombre AS "Product Name", p.precio, f.nombre AS "Manufacturer Name" FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE p.precio >= 180 ORDER BY p.precio DESC, p.nombre ASC;
-- 33. Return a list with code and name of manufacturers that have associated products.
SELECT DISTINCT f.codigo AS "Manufacturer Code", f.nombre AS "Manufacturer Name" FROM fabricante f INNER JOIN producto p ON f.codigo = p.codigo_fabricante;
-- 34. Return a list of all manufacturers with their products, including manufacturers with no products.
SELECT f.nombre AS "Manufacturer Name", p.nombre AS "Product Name" FROM fabricante f LEFT JOIN producto p ON f.codigo = p.codigo_fabricante;
-- 35. Return a list showing only manufacturers that have no associated products.
SELECT f.codigo AS "Manufacturer Code", f.nombre AS "Manufacturer Name" FROM fabricante f LEFT JOIN producto p ON f.codigo = p.codigo_fabricante WHERE p.codigo IS NULL;
-- 36. Return all products from manufacturer Lenovo (without INNER JOIN).
SELECT nombre AS "Product Name", precio FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo');
-- 37. Return all data of products with same price as most expensive product from Lenovo (without INNER JOIN).
SELECT * FROM producto WHERE precio = (SELECT MAX(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo'));
-- 38. List the name of the most expensive product from manufacturer Lenovo.
SELECT nombre AS "Product Name" FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo') ORDER BY precio DESC LIMIT 1;
-- 39. List the name of the cheapest product from manufacturer Hewlett-Packard.
SELECT nombre AS "Product Name" FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Hewlett-Packard') ORDER BY precio ASC LIMIT 1;
-- 40. Return all products with price >= most expensive product from Lenovo.
SELECT * FROM producto WHERE precio >= (SELECT MAX(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo'));
-- 41. List all products from Asus with price higher than average price of all their products.
SELECT p.nombre AS "Product Name", p.precio FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Asus' AND p.precio > (SELECT AVG(precio) FROM producto WHERE codigo_fabricante = f.codigo);