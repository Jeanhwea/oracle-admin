SET LINESIZE 255;
SET PAGESIZE 50000;
SET FEEDBACK OFF;
SET TAB OFF;

TTITLE LEFT 'List of User Sessions' SKIP 1 LINE;
-- COLUMN logintype FORMAT A10 HEADING 'Type';
COLUMN logontime HEADING 'Login Time';
COLUMN username FORMAT A12 HEADING 'User Name' TRUNCATE;
COLUMN servid FORMAT A12 HEADING 'Service Name';
COLUMN osid FORMAT A24 HEADING 'User@Hostname';
COLUMN program FORMAT A24 HEADING 'Program' TRUNCATE;
COLUMN status FORMAT A8 HEADING 'Status' TRUNCATE;
COLUMN state FORMAT A8 HEADING 'State' TRUNCATE;

SELECT
  sess.LOGON_TIME AS logontime,
  sess.USERNAME AS username,
  sess.SERVICE_NAME AS servid,
  sess.OSUSER || '@' || sess.MACHINE AS osid,
  sess.PROGRAM AS program,
  sess.STATUS AS status,
  sess.STATE AS state
  FROM V$SESSION sess
 WHERE sess.TYPE = 'USER'
 ORDER BY logontime DESC, username, status;
