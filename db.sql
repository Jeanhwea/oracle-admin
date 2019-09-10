SET LINESIZE 255;
SET PAGESIZE 50000;
SET FEEDBACK OFF;
SET TAB OFF;

TTITLE LEFT 'List of User Tablespaces' SKIP 1 LINE;
COLUMN tspname FORMAT A25 HEADING 'Tablespace Name';
COLUMN tspsize FORMAT A10 HEADING 'Total';
COLUMN tspubts FORMAT A10 HEADING 'User Size';
COLUMN tspmbts FORMAT A10 HEADING 'Max Size';
COLUMN tspfree FORMAT A10 HEADING 'Free';
COLUMN tspext FORMAT A8 HEADING 'Extent?';
COLUMN tspfile FORMAT A80 HEADING 'Data File';

-- desc USER_TABLESPACES

SELECT
  uts.TABLESPACE_NAME AS tspname,
  (
    SELECT TO_CHAR(SUM(dbdf.BYTES)/1024/1024, '99999.99') || 'M'
      FROM DBA_DATA_FILES dbdf
     WHERE uts.TABLESPACE_NAME = dbdf.TABLESPACE_NAME
  ) AS tspsize,
  -- (
  --   SELECT TO_CHAR(SUM(dbdf.USER_BYTES)/1024/1024, '99999.99') || 'M'
  --     FROM DBA_DATA_FILES dbdf
  --    WHERE uts.TABLESPACE_NAME = dbdf.TABLESPACE_NAME
  -- ) AS tspubts,
  -- (
  --   SELECT TO_CHAR(SUM(dbdf.MAXBYTES)/1024/1024, '99999.99') || 'M'
  --     FROM DBA_DATA_FILES dbdf
  --    WHERE uts.TABLESPACE_NAME = dbdf.TABLESPACE_NAME
  -- ) AS tspmbts,
  (
    SELECT TO_CHAR(SUM(dbfs.BYTES)/1024/1024, '99999.99') || 'M'
      FROM DBA_FREE_SPACE dbfs
     WHERE uts.TABLESPACE_NAME = dbfs.TABLESPACE_NAME
  ) AS tspfree,
  (
    SELECT LPAD(dbdf.AUTOEXTENSIBLE, 6, ' ')
      FROM DBA_DATA_FILES dbdf
     WHERE uts.TABLESPACE_NAME = dbdf.TABLESPACE_NAME
  ) AS tspext,
  (
    SELECT dbdf.FILE_NAME
      FROM DBA_DATA_FILES dbdf
     WHERE uts.TABLESPACE_NAME = dbdf.TABLESPACE_NAME
  ) AS tspfile
  FROM USER_TABLESPACES uts
 WHERE uts.ALLOCATION_TYPE = 'SYSTEM'
 GROUP BY uts.TABLESPACE_NAME
 ORDER BY tspname;
