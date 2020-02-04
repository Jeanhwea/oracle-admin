SET LINESIZE 255;
SET PAGESIZE 50000;
SET FEEDBACK OFF;
SET TAB OFF;

TTITLE LEFT 'List of User Tables' SKIP 1 LINE;
COLUMN table_name FORMAT A32 HEADING 'Table Name';
COLUMN tabcnt FORMAT 99999999 HEADING 'Count';


SET HEADING OFF;
TTITLE OFF;

SET TERMOUT OFF;
SPOOL .tmp.sql;
SELECT
  'SELECT ''' || utbs.TABLE_NAME || ''' AS table_name, COUNT(1) AS tabcnt FROM ' || utbs.TABLE_NAME || ';'
  FROM USER_TABLES utbs ORDER BY utbs.TABLE_NAME;
SPOOL OFF;
SET TERMOUT ON;

SET PAGESIZE 0;
@.tmp.sql;
SET PAGESIZE 50000;

TTITLE ON;
SET HEADING ON;

HOST rm .tmp.sql;
