-- 查看所有表和视图，以及注释
SET LINESIZE 128;
SET PAGESIZE 1024;
SET FEEDBACK OFF;

-- TTITLE CENTER 'List of Tables' SKIP 1 LINE;
-- COLUMN no FORMAT 9999 HEADING 'No.';
COLUMN tabname FORMAT A32 HEADING 'NAME';
COLUMN tabtype FORMAT A6 HEADING 'TYPE';
COLUMN tabcmt FORMAT A80 HEADING 'COMMENT';

SELECT tc.TABLE_NAME AS tabname,
       DECODE(tc.TABLE_TYPE, 'TABLE', 'Table', 'VIEW', 'View', '???') AS tabtype,
       REPLACE(REPLACE(TC.COMMENTS, CHR(13), ''), CHR(10), ' _R_N ') AS tabcmt
  FROM USER_TAB_COMMENTS tc
 WHERE tc.TABLE_TYPE = 'TABLE' AND
       REGEXP_LIKE(tc.TABLE_NAME, '^[0-9A-Za-z][_0-9A-Za-z]*$')
 ORDER BY tc.TABLE_NAME;
