
with mf
as
(
    select database_id, type, size * 8.0 / 1024 size
    from sys.master_files
)
select 
    name, db.is_auto_shrink_on, 
    (select sum(size) from mf where type = 0 and mf.database_id = db.database_id) DatosMB,
    (select sum(size) from mf where type = 1 and mf.database_id = db.database_id) LogMB
from sys.databases db