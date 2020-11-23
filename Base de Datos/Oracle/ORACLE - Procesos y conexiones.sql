------------------------------------------------ PARÁMETROS Y ESTADO DE LA BASE DE DATOS ---------------------------------------
-- INFORMACIÓN INSTANCIA 
-- Información del estado de una instancia de base de datos: estado, versión, nombre, cuando se levanto, el nombre de la máquina 

SELECT * FROM v$instance;
  
-- NOMBRE DE LA BASE DE DATOS --
-- A veces no sabemos donde estamos conectados, una forma es localizar el nombre de la base de datos 

SELECT value FROM v$system_parameter WHERE name = 'db_name';
 
-- PARÁMETROS DE LA BASE DE DATOS
-- Vista que muestra los parámetros generales de Oracle:

SELECT * FROM v$system_parameter;

SHOW PARAMETERS valor_a_buscar
 
-- PRODUCTOS ORACLE INSTALADOS Y LA VERSIÓN

SELECT * FROM product_component_version;
  
-- OBTENER LA IP DEL SERVIDOR DE LA BASE DE DATOS ORACLE DATABASE

SELECT utl_inaddr.get_host_address IP FROM DUAL;

-- QUERYS EN EJECUCION
 
SELECT O.OBJECT_NAME, S.SID, S.SERIAL#, P.SPID, S.PROGRAM,S.USERNAME,
S.MACHINE,S.PORT , S.LOGON_TIME,SQ.SQL_FULLTEXT 
FROM V$LOCKED_OBJECT L, DBA_OBJECTS O, V$SESSION S, 
V$PROCESS P, V$SQL SQ 
WHERE L.OBJECT_ID = O.OBJECT_ID 
AND L.SESSION_ID = S.SID AND S.PADDR = P.ADDR 
AND S.SQL_ADDRESS = SQ.ADDRESS;

-- COSAS --

select * from V$BACKUP;

select * from V$ARCHIVE; 

select * from V$LOG; 

select * from V$LOGFILE; 

select * from V$LOGHIST;     

select * from V$ARCHIVED_LOG;

select * from V$DATABASE;

-- CONSULTAS DE AUDITORIA --

select name, value
from v$parameter
where name like 'audit_trail';

select username, action_name, priv_used, returncode
from dba_audit_trail;
