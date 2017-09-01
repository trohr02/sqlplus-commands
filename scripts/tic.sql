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

COLUMN INDEX_NAME FORMAT A30
COLUMN COLUMN_NAME FORMAT A30
COLUMN INDEX_TYPE FORMAT A10
COLUMN PARTITIONED FORMAT A4
COLUMN JOIN_INDEX FORMAT A10
COLUMN STATUS FORMAT A6

SELECT
I.INDEX_NAME, IC.COLUMN_NAME, I.INDEX_TYPE,
CASE WHEN I.UNIQUENESS = 'UNIQUE' THEN 'U' ELSE ' ' END AS "UNIQUE",
I.PARTITIONED,
I.JOIN_INDEX,
I.STATUS
FROM ALL_INDEXES I
  JOIN ALL_IND_COLUMNS IC
    ON IC.INDEX_NAME = I.INDEX_NAME
    AND IC.INDEX_OWNER = I.OWNER
WHERE 1=1
-- if both &1 and &2 are not null then (owner like '&1' and table_name like '&2')
AND (('&1' IS NULL OR '&2' IS NULL) OR (I.OWNER LIKE '&1' AND I.TABLE_NAME LIKE '&2'))
-- if &2 is null then (owner=:owner and table_name like '&1')
AND	(('&2' IS NOT NULL) OR (I.OWNER=:OWNER AND I.TABLE_NAME LIKE '&1'))
ORDER BY I.INDEX_NAME, IC.COLUMN_POSITION
;

UNDEF 1
UNDEF 2

