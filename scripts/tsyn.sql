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
COLUMN SYNONYM_NAME FORMAT A30

SELECT
     OWNER
    ,SYNONYM_NAME
FROM ALL_SYNONYMS
WHERE 1=1
-- if both &1 and &2 are not null then (table_owner like '&1' and table_name like '&2')
AND (('&1' IS NULL OR '&2' IS NULL) OR (TABLE_OWNER LIKE '&1' AND TABLE_NAME LIKE '&2'))
-- if &2 is null then (table_owner=:owner and table_name like '&1')
AND	(('&2' IS NOT NULL) OR (TABLE_OWNER=:OWNER AND TABLE_NAME LIKE '&1'))
ORDER BY OWNER, SYNONYM_NAME
;

UNDEF 1
UNDEF 2
