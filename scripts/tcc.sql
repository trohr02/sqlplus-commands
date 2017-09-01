/*
Author: Tomas Rohr, rohr.tomas@gmail.com
Last change date: 2017-07-15
*/
SET VERIFY OFF

/*
Do not prompt for substitution variables values.
Use '%' as default value for substitution variable.
*/
COLUMN 1 NEW_VALUE 1
COLUMN 2 NEW_VALUE 2
SET FEEDBACK OFF
SELECT NULL "1", NULL "2" FROM DUAL WHERE 1=0;
SET FEEDBACK ON

COLUMN OWNER FORMAT A20
COLUMN CONSTRAINT_NAME FORMAT A20
COLUMN COLUMN_NAME FORMAT A30
COLUMN STATUS FORMAT A10

SELECT
     C.CONSTRAINT_TYPE
    ,C.CONSTRAINT_NAME
    ,CC.COLUMN_NAME
    ,C.STATUS
FROM ALL_CONSTRAINTS C
  INNER JOIN ALL_CONS_COLUMNS CC
		ON CC.OWNER = C.OWNER
		AND CC.TABLE_NAME = C.TABLE_NAME
		AND CC.CONSTRAINT_NAME = C.CONSTRAINT_NAME
WHERE 1=1
-- if both &1 and &2 are not null then (owner like '&1' and table_name like '&2')
AND (('&1' IS NULL OR '&2' IS NULL) OR (C.OWNER LIKE '&1' AND C.TABLE_NAME LIKE '&2'))
-- if &2 is null then (owner=:owner and table_name like '&1')
AND	(('&2' IS NOT NULL) OR (C.OWNER=:OWNER AND C.TABLE_NAME LIKE '&1'))
ORDER BY DECODE(C.CONSTRAINT_TYPE, 'P','A', 'U','B', 'R','C', 'C','D', C.CONSTRAINT_TYPE), C.CONSTRAINT_NAME, CC.POSITION
;

UNDEF 1
UNDEF 2

