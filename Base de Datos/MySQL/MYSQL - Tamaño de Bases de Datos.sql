-- ESPACIO DE BASE DE DATOS --

SELECT table_schema AS 'Base de datos',
ROUND(SUM(data_length + index_length) / 1024 / 1024, 2) AS 'Tamaño (MB)'
FROM information_schema.TABLES
GROUP BY table_schema;

-- ESPACIO DE TABLAS DE UNA BASE DE DATOS EN ESPECIFICO --

SELECT table_name AS 'Tabla',
ROUND((data_length + index_length) / 1024 / 1024 , 2) AS 'Tamaño (MB)'
FROM information_schema.TABLES
WHERE table_schema = 'sisp'
ORDER BY 1;