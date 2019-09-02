-- 查看所有表和视图，以及注释
SET LINESIZE 32767;
SET PAGESIZE 50000;
SET FEEDBACK OFF;
SET TAB OFF;

-- TTITLE CENTER 'List of Tables' SKIP 1 LINE;
-- COLUMN no FORMAT 9999 HEADING 'No.';
COLUMN tabname FORMAT A32 HEADING 'Name';
COLUMN tabtype FORMAT A6 HEADING 'Type';
COLUMN tabcmt FORMAT A80 HEADING 'Comment' TRUNCATE;

SELECT tc.TABLE_NAME AS tabname,
       DECODE(tc.TABLE_TYPE, 'TABLE', 'Table', 'VIEW', 'View', '???') AS tabtype,
       REPLACE(REPLACE(tc.COMMENTS, CHR(13), ''), CHR(10), ' _R_N ') AS tabcmt
  FROM USER_TAB_COMMENTS tc
 WHERE tc.TABLE_TYPE in ('TABLE', 'VIEW') AND
       REGEXP_LIKE(tc.TABLE_NAME, '^[0-9A-Za-z][_0-9A-Za-z]*$')
 ORDER BY tc.TABLE_NAME;
