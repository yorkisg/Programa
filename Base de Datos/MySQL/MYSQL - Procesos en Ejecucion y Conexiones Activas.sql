
-- VER PROCESOS Y QUERYS EN EJECUCION --
-- Threads_cached. Es el número de procesos cacheados actualmente.
-- Threads_connected. Número de conexiones activas actualmente.
-- Threads_create. Las conexiones que se han creado hasta el momento.
-- Threads_running. Las que se están ejecutando actualmente.

SHOW STATUS LIKE 'Threads%';

-- LISTAR PROCESOS EN EJECUCION --

SHOW PROCESSLIST;

-- LISTAR PROCESOS EN EJECUCION E INFORMACION ADICIONAL --

SHOW FULL PROCESSLIST;

SHOW GLOBAL STATUS;