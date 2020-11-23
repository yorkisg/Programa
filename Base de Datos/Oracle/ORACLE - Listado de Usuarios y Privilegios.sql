
-- LISTAR USUARIOS QUE TIENEN ACCESO A LA BASE DE DATOS -- 

SELECT USERNAME FROM DBA_USERS ORDER BY USERNAME ASC;

SELECT * FROM SYS.DBA_USERS ORDER BY USERNAME ASC;

SELECT * FROM ALL_USERS;

-- LISTAR LAS TABLAS A LAS QUE LOS USUARIOS ACCEDEN -- 

SELECT table_name FROM user_tables ORDER BY table_name;

SELECT table_name FROM all_tables WHERE OWNER ='JUAN' ORDER BY table_name;

-- LISTAR SESIONES Y USUARIOS ACTIVOS/INACTIVOS --

SELECT * FROM GV$SESSION where STATUS='INACTIVE' AND SCHEMANAME NOT IN ('INFOCENT', 'SYS', 'SYSTEM','SYSMAN', 'SYSAUX') ORDER BY USERNAME ASC;

-- ELIMINAR SESIONES DE USUARIOS ACTIVOS/INACTIVOS --

SELECT 'ALTER SYSTEM KILL SESSION ''' ||SID||','||SERIAL#|| ''' IMMEDIATE;' FROM GV$SESSION where STATUS='INACTIVE' AND SCHEMANAME NOT IN ('INFOCENT', 'SYS', 'SYSTEM','SYSMAN', 'SYSAUX');

-- LISTAR SESIONES Y FECHA DE INICIO DE SESION --

SELECT username AS USUARIO, status AS ESTATUS, osuser AS USER_SISTEMAOPERATIVO, machine AS TERMINAL, TO_CHAR(logon_Time,'DD-MON-YYYY HH24:MI:SS') AS INICIO_SESION 
FROM GV$SESSION 
WHERE SCHEMANAME  NOT IN ('INFOCENT', 'SYS', 'SYSTEM','SYSMAN', 'SYSAUX')
AND osuser NOT IN ('IBM-1')
ORDER BY 1;

-- LISTADO DE USUARIOS CONECTADOS Y FECHA DE CONEXION --

SELECT s.username, s.program, s.logon_time
FROM v$session s, v$process p, sys.v_$sess_io si
WHERE s.paddr = p.addr(+)
AND si.sid(+) = s.sid
ORDER BY s.logon_time DESC;

SELECT osuser, username, machine, program 
  FROM v$session 
  ORDER BY osuser;

-- SENTENCIAS SQL QUE ESTAN EN USO --
  
SELECT O.OBJECT_NAME, S.SID, S.SERIAL#, P.SPID, S.PROGRAM,S.USERNAME,
       S.MACHINE,S.PORT , S.LOGON_TIME,SQ.SQL_FULLTEXT
FROM V$LOCKED_OBJECT L, DBA_OBJECTS O, V$SESSION S,
     V$PROCESS P, V$SQL SQ
WHERE L.OBJECT_ID = O.OBJECT_ID
  AND L.SESSION_ID = S.SID 
  AND S.PADDR = P.ADDR
  AND S.SQL_ADDRESS = SQ.ADDRESS; 

-----------------------------------------------LISTAR SESIONES Y ESTATUS--------------------------------------------------------

SELECT USERNAME, ACCOUNT_STATUS FROM SYS.DBA_USERS;

-- LISTAR PRIVILEGIOS DE UN USUARIO EN ESPECIFICO --

SELECT * FROM USER_ROLE_PRIVS WHERE USERNAME = 'INFOCENT';

SELECT * FROM USER_TAB_PRIVS WHERE Grantee = 'INFOCENT';

SELECT * FROM USER_SYS_PRIVS WHERE USERNAME = 'INFOCENT';

-- LISTAR PRIVILEGIOS DEL USUARIO ACTUAL --

SELECT * FROM USER_ROLE_PRIVS WHERE USERNAME= USER;

SELECT * FROM USER_TAB_PRIVS WHERE Grantee = USER;

SELECT * FROM USER_SYS_PRIVS WHERE USERNAME = USER;

-- LISTAR PERMISOS CONCEDIDOS A USUARIO --

SELECT * FROM ROLE_ROLE_PRIVS WHERE ROLE IN (SELECT granted_role FROM USER_ROLE_PRIVS WHERE USERNAME= USER);

SELECT * FROM ROLE_TAB_PRIVS  WHERE ROLE IN (SELECT granted_role FROM USER_ROLE_PRIVS WHERE USERNAME= USER);

SELECT * FROM ROLE_SYS_PRIVS  WHERE ROLE IN (SELECT granted_role FROM USER_ROLE_PRIVS WHERE USERNAME= USER);

-- Vista que muestra el número de conexiones actuales a Oracle agrupado por aplicación que realiza la conexión

select program Aplicacion, count(program) Numero_Sesiones
from v$session
group by program 
order by Numero_Sesiones desc;

--Vista que muestra los usuarios de Oracle conectados y el número de sesiones por usuario

select username Usuario_Oracle, count(username) Numero_Sesiones
from v$session
group by username
order by Numero_Sesiones desc;

---------------------------------------------------CONFIRMAR CAMBIOS------------------------------------------------------------

COMMIT WORK;


