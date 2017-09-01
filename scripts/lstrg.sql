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
COLUMN TRIGGER_TYPE FORMAT A17
COLUMN TABLE_OWNER FORMAT A15
COLUMN TABLE_NAME FORMAT A30
COLUMN STATUS FORMAT A8


SELECT
     OWNER
    ,TRIGGER_NAME
    ,TRIGGER_TYPE
    ,TABLE_OWNER
    ,TABLE_NAME
    ,STATUS
FROM ALL_TRIGGERS
WHERE 1=1
-- if both &1 and &2 are not null then (owner like '&1' and trigger_name like '&2')
AND (('&1' IS NULL OR '&2' IS NULL) OR (OWNER LIKE '&1' AND TRIGGER_NAME LIKE '&2'))
-- if &1 is not null and &2 is null then (owner=:owner and trigger_name like '&1')
AND	(('&1' IS NULL OR '&2' IS NOT NULL) OR (OWNER=:OWNER AND TRIGGER_NAME LIKE '&1'))
-- if both &1 and &2 are null then owner = :owner
AND (('&1' IS NOT NULL) OR (OWNER = :OWNER))
ORDER BY TRIGGER_NAME, OWNER
;

UNDEF 1
UNDEF 2