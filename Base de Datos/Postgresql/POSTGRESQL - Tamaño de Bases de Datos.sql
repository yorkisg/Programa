
-- ESPACIO DE BD EN POSTGRESQL --

SELECT datname AS db_name, pg_size_pretty(pg_database_size(datname)) AS db_size
FROM pg_database 
ORDER BY pg_database_size(datname) DESC;

-- ESPACIO DE UNA BASE DE DATOS EN ESPECIFICO --

SELECT pg_database_size('db_bi_dev');

SELECT pg_size_pretty( pg_database_size('db_bi_dev') );

