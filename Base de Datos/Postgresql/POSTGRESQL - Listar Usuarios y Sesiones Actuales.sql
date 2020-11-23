
-- LISTAR USUARIOS DE BASE DE DATOS --

SELECT * FROM pg_user;

-- LISTAR USUARIOS --

SELECT rolname FROM pg_roles;

-- LISTAR PRIVILEGIOS POR USUARIO --

SELECT grantee,table_catalog, table_schema, table_name, privilege_type
FROM   information_schema.table_privileges 
WHERE  grantee NOT IN ('pg_monitor','PUBLIC');

SELECT grantee, table_catalog, privilege_type, table_schema, table_name 
FROM information_schema.table_privileges 
ORDER BY grantee, table_schema, table_name;

SELECT grantee,table_catalog, table_schema, table_name, string_agg(privilege_type, ' - ')
FROM   information_schema.table_privileges 
WHERE  grantee NOT IN ('pg_monitor','PUBLIC')
GROUP BY grantee,table_catalog, table_schema, table_name;	

-- LISTAR ACTIVIDAD DE USUARIOS --

SELECT * FROM pg_stat_activity;

-- CAMBIAR PASSWORD DE USUARIO --

ALTER USER pilar with password ‘123456’;

-- CAMBIAR NOMBRE DE USUARIO --

ALTER USER pilar RENAME TO manolo;

-- VER QUERYS EN EJECUCION --

SELECT pid, age(query_start, clock_timestamp()), usename, query 
FROM pg_stat_activity 
WHERE query != '<IDLE>' AND query NOT ILIKE '%pg_stat_activity%' 
ORDER BY query_start DESC;

-- DESTRUIR QUERYS EN EJECUCION --

SELECT pg_cancel_backend(procpid);

