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
COLUMN NAME FORMAT A30
COLUMN COLUMN_NAME FORMAT A30
COLUMN COLUMN_NAME FORMAT 9
COLUMN PARTITION_NAME FORMAT A30
COLUMN HIGH_VALUE FORMAT A85
COLUMN NUM_ROWS FORMAT 99G999G999

SELECT
     OWNER
    ,NAME
    ,OBJECT_TYPE
    ,COLUMN_NAME
    ,COLUMN_POSITION AS P
FROM ALL_PART_KEY_COLUMNS
WHERE 1=1
-- if both &1 and &2 are not null then (owner like '&1' and table_name like '&2')
AND (('&1' IS NULL OR '&2' IS NULL) OR (C.OWNER LIKE '&1' AND C.TABLE_NAME LIKE '&2'))
-- if &2 is null then (owner=:owner and table_name like '&1')
AND	(('&2' IS NOT NULL) OR (C.OWNER=:OWNER AND C.TABLE_NAME LIKE '&1'))
ORDER BY NAME, OWNER, COLUMN_POSITION
;


SELECT
     PARTITION_NAME
    ,HIGH_VALUE
    ,NUM_ROWS
    ,LAST_ANALYZED
FROM (
    SELECT
         PARTITION_NAME
        ,HIGH_VALUE
        ,NUM_ROWS
        ,LAST_ANALYZED
    FROM ALL_TAB_PARTITIONS
    WHERE 1=1
    -- if both &1 and &2 are not null then (owner like '&1' and table_name like '&2')
    AND (('&1' IS NULL OR '&2' IS NULL) OR (C.OWNER LIKE '&1' AND C.TABLE_NAME LIKE '&2'))
    -- if &2 is null then (owner=:owner and table_name like '&1')
    AND	(('&2' IS NOT NULL) OR (C.OWNER=:OWNER AND C.TABLE_NAME LIKE '&1'))
    ORDER BY PARTITION_NAME DESC
) X
WHERE ROWNUM <= 4
;

UNDEF 1
UNDEF 2

