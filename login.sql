-- show date
set time on
-- show timer
set timing on
-- show NULL
set null 'NULL'
-- size per line
set linesize 300
-- trim space
set trimspool on
-- show selected line
set feedback on 
-- cloumn sepalater
set colsep ' '
-- set page
set pages 100

-- sqlprompt
set sqlprompt "&_user.@&_connect_identifier> "

-- format
col OWNER           for a32
col TABLE_NAME      for a32
col INDEX_NAME      for a32
col TABLESPACE_NAME for a32
col INDEX_OWNER     for a32
col TABLE_OWNER     for a32
col COLUMN_NAME     for a32
col PARTITION_NAME  for a32
