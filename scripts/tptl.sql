/*
Author: Tomas Rohr, rohr.tomas@gmail.com
Last change date: 2017-09-01
*/
SET VERIFY OFF

/*
Do not prompt for substitution variables values.
Use null as default value for substitution variable.
*/
COLUMN 1 NEW_VALUE 1
COLUMN 2 NEW_VALUE 2
SET FEEDBACK OFF
SELECT NULL "1", NULL "2" FROM DUAL WHERE 1=0;
SET FEEDBACK ON

COLUMN PARTITION_NAME FORMAT A30
COLUMN HIGH_VALUE FORMAT A50
COLUMN NUM_ROWS FORMAT 99G999G999


SELECT
     PARTITION_NAME
    ,HIGH_VALUE
    ,NUM_ROWS
    ,LAST_ANALYZED
    ,CASE WHEN "INTERVAL" = 'YES' THEN 'I' ELSE 'L' END PART_TYPE
FROM ALL_TAB_PARTITIONS P
WHERE 1=1
-- if both &1 and &2 are not null then (owner like '&1' and table_name like '&2')
AND (('&1' IS NULL OR '&2' IS NULL) OR (P.TABLE_OWNER LIKE '&1' AND P.TABLE_NAME LIKE '&2'))
-- if &2 is null then (owner=:owner and table_name like '&1')
AND	(('&2' IS NOT NULL) OR (P.TABLE_OWNER=:OWNER AND P.TABLE_NAME LIKE '&1'))
ORDER BY PARTITION_NAME DESC
;

UNDEF 1
UNDEF 2

