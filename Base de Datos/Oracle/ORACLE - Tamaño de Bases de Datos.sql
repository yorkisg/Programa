
------------------------------------------------------- UBICACIÓN DE FICHEROS --------------------------------------------------
-- LOCALIZAR UBICACIÓN Y NOMBRE DEL FICHERO SPFILE
-- Como el fichero de parámetros puede haberse cambiado de lugar, se puede localizar de la siguiente manera

SELECT value FROM v$system_parameter WHERE name = 'spfile';
 
-- LOCALIZAR UBICACIÓN Y NOMBRE DE LOS FICHEROS DE CONTROL
-- Como el fichero de parámetros puede haberse cambiado de lugar, se puede localizar de la siguiente manera

-- Ubicación y número de ficheros de control:

SELECT value FROM v$system_parameter WHERE name = 'control_files';
 
-- TODOS LOS FICHEROS DE DATOS Y SU UBICACIÓN

SELECT * FROM V$DATAFILE;
  
-- FICHEROS TEMPORALES

SELECT * FROM V$TEMPFILE;
  
-- FICHEROS DE REDO LOG

SELECT member FROM v$logfile;
  
-- FICHEROS DE ARCHIVE LOG

SHOW parameters archive_dest

------------------------------------------------------------- VOLUMETRÍA -------------------------------------------------------
-- ESPACIO UTILIZADO POR LOS TABLESPACES
-- Consulta SQL para el DBA de Oracle que muestra los tablespaces, el espacio utilizado, el espacio libre y los ficheros de datos de los mismos

SELECT t.tablespace_name                      "Tablespace",
       t.status                               "Estado",
       ROUND (MAX (d.bytes) / 1024 / 1024, 2) "MB Tamaño",
       ROUND ((MAX (d.bytes) / 1024 / 1024)
                  - (SUM (DECODE (f.bytes, NULL, 0, f.bytes)) / 1024 / 1024),
               2)                             "MB Usados",
       ROUND (SUM (DECODE (f.bytes, NULL, 0, f.bytes)
                   ) / 1024 / 1024, 2)        "MB Libres",
       t.pct_increase                         "% incremento",
       SUBSTR (d.file_name, 1, 80)            "Fichero de datos"
  FROM DBA_FREE_SPACE f, DBA_DATA_FILES d, DBA_TABLESPACES t
 WHERE t.tablespace_name = d.tablespace_name
   AND f.tablespace_name(+) = d.tablespace_name
   AND f.file_id(+) = d.file_id
 GROUP BY t.tablespace_name,
       d.file_name,
       t.pct_increase,
       t.status
 ORDER BY 1, 3 DESC;
 
-- TAMAÑO OCUPADO POR LA BASE DE DATOS --

SELECT SUM(BYTES)/1024/1024 MB FROM DBA_EXTENTS; 
  
-- TAMAÑO DE LOS FICHEROS DE DATOS DE LA BASE DE DATOS --

SELECT SUM(bytes)/1024/1024 MB FROM dba_data_files;
  
-- TAMAÑO OCUPADO POR UNA TABLA CONCRETA SIN INCLUIR LOS ÍNDICES DE LA MISMA --

SELECT SUM(bytes)/1024/1024 MB 
  FROM user_segments
 WHERE segment_type='TABLE'
   AND segment_name='NOMBRETABLA';
   
-- TAMAÑO OCUPADO POR UNA TABLA CONCRETA INCLUYENDO LOS ÍNDICES DE LA MISMA --

SELECT SUM(bytes)/1024/1024 Table_Allocation_MB 
  FROM user_segments
 WHERE segment_type in ('TABLE','INDEX')
   AND(segment_name='V_NOMINA_H' 
       OR segment_name IN (SELECT index_name 
			     FROM user_indexes 
		            WHERE table_name='V_NOMINA_H'));
					
-- TAMAÑO OCUPADO POR UNA COLUMNA DE UNA TABLA --

SELECT SUM(vsize('Nombre_Columna'))/1024/1024 MB FROM nombre_Tabla;
  
-- ESPACIO OCUPADO POR USUARIO --

SELECT owner, SUM(BYTES)/1024/1024 FROM DBA_EXTENTS MB GROUP BY owner;
 
-- ESPACIO OCUPADO POR LOS DIFERENTES SEGMENTOS (TABLAS, ÍNDICES, UNDO, ROLLBACK, CLUSTER, …) -- 

SELECT SEGMENT_TYPE, SUM(BYTES)/1024/1024 
  FROM DBA_EXTENTS MB
 GROUP BY SEGMENT_TYPE;
 
-- OCUPACIÓN DE TODOS LOS OBJETOS DE LA BASE DE DATOS --
-- Espacio ocupado por todos los objetos de la base de datos, muestra primero los objetos que más ocupan --

SELECT SEGMENT_NAME,
       SUM(BYTES)/1024/1024 
  FROM DBA_EXTENTS MB
 GROUP BY SEGMENT_NAME
 ORDER BY 2 DESC;
 
-------------------------------------------------- OBJETOS DE LA BASE DE DATOS -------------------------------------------------
-- PROPIETARIOS DE OBJETOS Y NÚMERO DE OBJETOS POR PROPIETARIO --

SELECT owner,
       COUNT(owner) Numero 
  FROM dba_objects 
 GROUP BY owner 
 ORDER BY Numero DESC;
 
-- MUESTRA LOS DISPARADORES (TRIGGERS) DE LA BASE DE DATOS ORACLE DATABASE --

SELECT * FROM ALL_TRIGGERS;
  
-- REGLAS DE INTEGRIDAD Y COLUMNA A LA QUE AFECTAN --

SELECT constraint_name, column_name FROM sys.all_cons_columns;
  
-- TABLAS DE LAS QUE ES PROPIETARIO UN USUARIO DETERMINADO --

SELECT table_owner, table_name FROM sys.all_synonyms WHERE table_owner = 'SCOTT';
 
-- INFORMACIÓN TABLESPACES --

SELECT * FROM V$TABLESPACE;
  
-- BUSQUEDAS DE CONSTRAINTS DESHABILITADAS --

SELECT TABLE_NAME, CONSTRAINT_NAME, STATUS
  FROM ALL_CONSTRAINTS   
 WHERE OWNER  <> 'SIEBEL'
   AND STATUS = 'DISABLED';
   
-- TABLAS CON MÁS DE UN NÚMERO DETERMINADO DE ÍNDICES --

SELECT TABLE_NAME, COUNT(*) 
  FROM ALL_INDEXES
 WHERE OWNER='SIEBEL'
 GROUP BY TABLE_NAME
HAVING COUNT(*) > 5
 ORDER BY 2 DESC;
 
-- TABLAS SIN PRÍMARY KEY

SELECT TABLE_NAME 
  FROM ALL_TABLES T
 WHERE OWNER = 'SIEBEL'
   AND NOT EXISTS (SELECT 1 FROM ALL_CONSTRAINTS C WHERE T.OWNER  = C.OWNER AND CONSTRAINT_TYPE = 'P');
					  
-- OBJETOS NO VÁLIDOS (PAQUETES, PROCEDIMIENTOS, FUNCIONES, TRIGGERS, VISTAS,…)

SELECT OBJECT_NAME, OBJECT_TYPE
  FROM all_objects
 WHERE OWNER = 'SIEBEL'
   AND STATUS <> 'VALID';
   
-- OBJETOS CREADOS EN LA ÚLTIMA HORA

SELECT OBJECT_NAME,
       OBJECT_TYPE, 
       LAST_DDL_TIME, 
       CREATED, 
       TIMESTAMP, 
       STATUS
  FROM all_objects
 WHERE OWNER = 'SIEBEL'
   AND CREATED > sysdate - 1/24;
   
-- OBJETOS MODIFICADOS EN LA ÚLTIMA HORA

SELECT OBJECT_NAME,
       OBJECT_TYPE,
       LAST_DDL_TIME,
       CREATED,
       TIMESTAMP,
       STATUS
  FROM all_objects
 WHERE OWNER = 'SIEBEL'
   AND TIMESTAMP > sysdate - 1;
   
-- INFORMACIÓN DE COLUMNAS DE UNA TABLA

SELECT TABLE_NAME,
       COLUMN_NAME,
       DATA_TYPE,
       DATA_LENGTH,
       DATA_PRECISION,
       NULLABLE
  FROM ALL_TAB_COLUMNS
 WHERE OWNER = 'SIEBEL'
   AND TABLE_NAME = 'MI_TABLA'
 ORDER BY TABLE_NAME, COLUMN_ID;

-- AUMENTAR TAMAÑO DATAFILE

ALTER DATABASE DATAFILE '+DATA/spi/datafile/spiidx.276.904224859'
RESIZE 15000M;

ALTER DATABASE DATAFILE '+DATA/spi/datafile/spiidx.276.904224859'
AUTOEXTEND ON NEXT 10M 
MAXSIZE 15000M;


