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

COLUMN OWNER FORMAT A30
COLUMN OBJECT_NAME FORMAT A30
COLUMN STATUS FORMAT A10


SELECT
     OWNER
    ,OBJECT_NAME
    ,STATUS
FROM ALL_OBJECTS
WHERE OBJECT_TYPE IN ('PACKAGE')
-- if both &1 and &2 are not null then (owner like '&1' and object_name like '&2')
AND (('&1' IS NULL OR '&2' IS NULL) OR (OWNER LIKE '&1' AND OBJECT_NAME LIKE '&2'))
-- if &1 is not null and &2 is null then (owner=:owner and object_name like '&1')
AND	(('&1' IS NULL OR '&2' IS NOT NULL) OR (OWNER=:OWNER AND OBJECT_NAME LIKE '&1'))
-- if both &1 and &2 are null then owner = :owner
AND (('&1' IS NOT NULL) OR (OWNER = :OWNER))
;

UNDEF 1
UNDEF 2

