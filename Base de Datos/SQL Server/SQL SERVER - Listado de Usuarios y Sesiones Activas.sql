
-- LISTAR USUARIOS --

SELECT name, type_desc
FROM sys.server_principals
WHERE type_desc IN('SQL_LOGIN', 'WINDOWS_LOGIN', 'WINDOWS_GROUP');

SELECT * FROM sysusers

SELECT * FROM syslogins 

SELECT * FROM sys.database_principals 

SELECT * FROM sys.server_principals

SELECT * FROM sys.sql_logins

SELECT @@ServerName AS server,
  NAME AS dbname,
  LOGINAME AS LoginName,
  COUNT(STATUS) AS number_of_connections,
  GETDATE() AS timestamp
FROM sys.databases sd
LEFT JOIN sys.sysprocesses sp ON sd.database_id = sp.dbid
WHERE database_id NOT BETWEEN 1 AND 4
AND LOGINAME IS NOT NULL
GROUP BY NAME,LOGINAME;

SELECT DB_NAME(dbid) as DBName, COUNT(dbid) as NumberOfConnections, loginame as LoginName
FROM sys.sysprocesses
WHERE dbid > 0
GROUP BY dbid, loginame
ORDER BY 1;

-- LISTAR USUARIOS Y PERMISOS --

SELECT SP1.[name] AS 'Login', 'Role: ' + SP2.[name] COLLATE DATABASE_DEFAULT AS 'ServerPermission'
FROM sys.server_principals SP1
  JOIN sys.server_role_members SRM
    ON SP1.principal_id = SRM.member_principal_id
  JOIN sys.server_principals SP2
    ON SRM.role_principal_id = SP2.principal_id
UNION ALL
SELECT SP.[name] AS 'Login' , SPerm.state_desc + ' ' + SPerm.permission_name COLLATE DATABASE_DEFAULT AS 'ServerPermission'  FROM sys.server_principals SP
  JOIN sys.database_permissions SPerm
    ON SP.principal_id = SPerm.grantee_principal_id
ORDER BY [Login], [ServerPermission];