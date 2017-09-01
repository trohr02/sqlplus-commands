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

COLUMN OWNER FORMAT A15
COLUMN TRIGGER_NAME FORMAT A28
COLUMN ST FORMAT A2
COLUMN TRIGGER_TYPE FORMAT A17
COLUMN TRIGGERING_EVENT FORMAT A33

SELECT
     OWNER
    ,TRIGGER_NAME
    ,SUBSTR(STATUS,1,1) AS ST
    ,TRIGGER_TYPE
    ,TRIGGERING_EVENT
    ,BEFORE_STATEMENT AS BS
    ,BEFORE_ROW AS BR
    ,AFTER_ROW AS AR
    ,AFTER_STATEMENT AS "AS"
    ,INSTEAD_OF_ROW AS IOF
FROM ALL_TRIGGERS
WHERE 1=1
-- if both &1 and &2 are not null then (owner like '&1' and table_name like '&2')
AND (('&1' IS NULL OR '&2' IS NULL) OR (OWNER LIKE '&1' AND TABLE_NAME LIKE '&2'))
-- if &2 is null then (owner=:owner and table_name like '&1')
AND	(('&2' IS NOT NULL) OR (OWNER=:OWNER AND TABLE_NAME LIKE '&1'))
ORDER BY OWNER, TRIGGER_NAME
;

UNDEF 1
UNDEF 2
