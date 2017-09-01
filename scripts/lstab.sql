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

COLUMN OWNER FORMAT A20
COLUMN TABLE_NAME FORMAT A30
COLUMN TABLESPACE_NAME FORMAT A30
COLUMN NUM_ROWS FORMAT 999999999999
COLUMN STATUS FORMAT A10
COLUMN PARTITIONED FORMAT A11
COLUMN TEMPORARY FORMAT A9

SELECT
     OWNER
    ,TABLE_NAME
    ,TABLESPACE_NAME
    ,STATUS
    ,PARTITIONED
    ,TEMPORARY
FROM ALL_TABLES
WHERE 1=1
-- if both &1 and &2 are not null then (owner like '&1' and table_name like '&2')
AND (('&1' IS NULL OR '&2' IS NULL) OR (OWNER LIKE '&1' AND TABLE_NAME LIKE '&2'))
-- if &1 is not null and &2 is null then (owner=:owner and table_name like '&1')
AND	(('&1' IS NULL OR '&2' IS NOT NULL) OR (OWNER=:OWNER AND TABLE_NAME LIKE '&1'))
-- if both &1 and &2 are null then owner = :owner
AND (('&1' IS NOT NULL) OR (OWNER = :OWNER))
ORDER BY OWNER, TABLE_NAME
;

UNDEF 1
UNDEF 2
