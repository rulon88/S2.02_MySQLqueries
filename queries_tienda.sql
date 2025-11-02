USE tienda;
-- Query #1: List the name of all products in the product table.
SELECT nombre FROM producto;
-- Query #2: List the names and prices of all products in the product table.
SELECT nombre, precio FROM producto;
-- Query #3: List all columns from the product table.
SELECT * FROM producto;
-- Query #4: List the product names, price in euros and price in US dollars (USD).
SELECT nombre, ROUND(precio, 2) AS precio_eur, ROUND(precio * 1.08, 2) AS precio_usd FROM producto;
-- Query #5: List the product names, price in euros and price in US dollars (USD). Using the following column aliases: product name, euros, dollars.
SELECT nombre AS 'product name', ROUND(precio, 2) AS euros, ROUND(precio * 1.08, 2) AS dollars FROM producto;
-- Query #6: List the names and prices of all products in the product table, converting the names to uppercase.
SELECT UPPER(nombre), precio FROM producto;
-- Query #7: List the names and prices of all products in the product table, converting the names to lowercase.
SELECT LOWER(nombre), precio FROM producto;
-- Query #8: List all manufacturers names in one column, and in another column capitalize the first two characters of the manufacturer name.
SELECT nombre, UPPER(LEFT(nombre, 2)) AS initials FROM fabricante;
-- Query #9: List the names and prices of all products in the product table, rounding the price value.
SELECT nombre, ROUND(precio) AS rounded_price FROM producto;
-- Query #10: List the names and prices of all products in the product table, truncating the price value to display it without any decimal places.
SELECT nombre, TRUNCATE(precio, 0) AS price_no_decimals FROM producto;
-- Query #11: List the codes of the manufacturers that have products in the product table.
SELECT DISTINCT codigo_fabricante FROM producto;
-- Query #12: List the codes of the manufacturers that have products in the product table, eliminating any codes that appear repeatedly.
SELECT DISTINCT codigo_fabricante FROM producto;
-- Query #13: List the names of manufacturers in ascending order.
SELECT nombre FROM fabricante ORDER BY nombre;
-- Query #14: List the names of manufacturers in descending order.
SELECT nombre FROM fabricante ORDER BY nombre DESC;
-- Query #15: List product names sorted, first by name in ascending order, and second by price in descending order.
SELECT nombre, precio FROM producto ORDER BY nombre ASC, precio DESC;
-- Query #16: Return a list with the first 5 rows of the manufacturer table.
SELECT * FROM fabricante LIMIT 5;
-- Query #17: Return a list with two rows starting from the fourth row of the manufacturer table. The fourth row also are included.
SELECT * FROM fabricante LIMIT 2 OFFSET 3;
-- Query #18: List the name and price of the cheapest product. (Using only the ORDER BY and LIMIT clauses).
SELECT nombre, precio FROM producto ORDER BY precio ASC LIMIT 1;
-- Query #19: List the name and price of the most expensive product. (Using only the ORDER BY and LIMIT clauses).
SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;
-- Query #20: List the name of all products from the manufacturer whose manufacturer code is equal to 2.
SELECT nombre FROM producto WHERE codigo_fabricante = 2;
-- Query #21: Return a list with the product name, price, and manufacturer name of all products in the database.
SELECT p.nombre AS "Product Name", p.precio, f.nombre AS "Manufacturer Name" FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo;
-- Query #22: Return a list with the product name, price, and manufacturer name of all products in the database. Sorting the result by manufacturer name, alphabetically.
SELECT p.nombre AS "Product Name", p.precio, f.nombre AS "Manufacturer Name" FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo ORDER BY f.nombre ASC;
-- Query #23: Return a list with the product code, product name, manufacturer code, and manufacturer name for all products in the database.
SELECT p.codigo AS "Product Code", p.nombre AS "Product Name", f.codigo AS "Manufacturer Code", f.nombre AS "Manufacturer Name" FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo;
-- Query #24: Return the product name, its price and the name of its manufacturer, of the cheapest product.
SELECT p.nombre AS "Product Name", p.precio, f.nombre AS "Manufacturer Name" FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo ORDER BY p.precio ASC LIMIT 1;
-- Query #25: Return the product name, its price and the name of its manufacturer, of the most expensive product.
SELECT p.nombre AS "Product Name", p.precio, f.nombre AS "Manufacturer Name" FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo ORDER BY p.precio DESC LIMIT 1;
-- Query #26: Return a list of all products from the manufacturer Lenovo.
SELECT p.nombre AS "Product Name", p.precio FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Lenovo';
-- Query #27: Return a list of all products from the manufacturer Crucial that have a price greater than €200.
SELECT p.nombre AS "Product Name", p.precio, f.nombre AS "Manufacturer Name" FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Crucial' AND p.precio > 200;
-- Query #28: Return a list with all products from the manufacturers Asus, Hewlett-Packard and Seagate. Without using the IN operator.
SELECT p.nombre AS "Product Name", f.nombre AS "Manufacturer Name" FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Asus' OR f.nombre = 'Hewlett-Packard' OR f.nombre = 'Seagate';
-- Query #29: Return a list with all products from the manufacturers Asus, Hewlett-Packard and Seagate. Using the IN operator.
SELECT p.nombre AS "Product Name", f.nombre AS "Manufacturer Name" FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre IN ('Asus', 'Hewlett-Packard', 'Seagate');
-- Query #30: Return a list with the name and price of all products from manufacturers whose name ends with the vowel e.
SELECT p.nombre AS "Product Name", p.precio, f.nombre AS "Manufacturer Name" FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE LOWER(f.nombre) LIKE '%e';
-- Query #31: Return a list with the name and price of all products whose manufacturer name contains the character w in its name.
SELECT p.nombre AS "Product Name", p.precio, f.nombre AS "Manufacturer Name" FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE LOWER(f.nombre) LIKE '%w%';
-- Query #32: Return a list with the product name, price and manufacturer name of all products with a price greater than or equal to €180. Sorting the result first by price (in descending order) and second by name (in ascending order).
SELECT p.nombre AS "Product Name", p.precio, f.nombre AS "Manufacturer Name" FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE p.precio >= 180 ORDER BY p.precio DESC, p.nombre ASC;
-- Query #33: Return a list with the code and name of manufacturer, only those manufacturers that have associated products in the database.
SELECT DISTINCT f.codigo AS "Manufacturer Code", f.nombre AS "Manufacturer Name" FROM fabricante f INNER JOIN producto p ON f.codigo = p.codigo_fabricante;
-- Query #34: Return a list of all manufacturers that exist in the database, together with the products each one has. The list should also show manufacturers with no associated products.
SELECT f.nombre AS "Manufacturer Name", p.nombre AS "Product Name" FROM fabricante f LEFT JOIN producto p ON f.codigo = p.codigo_fabricante;
-- Query #35: Return a list showing only manufacturers that have no associated products.
SELECT f.codigo AS "Manufacturer Code", f.nombre AS "Manufacturer Name" FROM fabricante f LEFT JOIN producto p ON f.codigo = p.codigo_fabricante WHERE p.codigo IS NULL;
-- Query #36: Return all products from manufacturer Lenovo. (Without using INNER JOIN).
SELECT nombre AS "Product Name", precio FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo');
-- Query #37: Return all data of products that have the same price as the most expensive product from manufacturer Lenovo. (Without using INNER JOIN).
SELECT * FROM producto WHERE precio = (SELECT MAX(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo'));
-- Query #38: List the name of the most expensive product from manufacturer Lenovo.
SELECT nombre AS "Product Name" FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo') ORDER BY precio DESC LIMIT 1;
-- Query #39: List the name of the cheapest product from manufacturer Hewlett-Packard.
SELECT nombre AS "Product Name" FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Hewlett-Packard') ORDER BY precio ASC LIMIT 1;
-- Query #40: Return all products from the database that have a price greater than or equal to the most expensive product from manufacturer Lenovo.
SELECT * FROM producto WHERE precio >= (SELECT MAX(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo'));
-- Query #41: List all products from manufacturer Asus that have a price higher than the average price of all their products.
SELECT p.nombre AS "Product Name", p.precio FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Asus' AND p.precio > (SELECT AVG(precio) FROM producto WHERE codigo_fabricante = f.codigo);