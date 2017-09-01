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
COLUMN MVIEW_NAME FORMAT A30
COLUMN REFRESH_MODE FORMAT A6
COLUMN REFRESH_METHOD FORMAT A8
COLUMN BUILD_MODE FORMAT A9
COLUMN STALENESS FORMAT A13

SELECT
     OWNER
    ,MVIEW_NAME
    ,REFRESH_MODE
    ,REFRESH_METHOD
    ,BUILD_MODE
    ,STALENESS
FROM ALL_MVIEWS
WHERE 1=1
-- if both &1 and &2 are not null then (owner like '&1' and mview_name like '&2')
AND (('&1' IS NULL OR '&2' IS NULL) OR (OWNER LIKE '&1' AND MVIEW_NAME LIKE '&2'))
-- if &1 is not null and &2 is null then (owner=:owner and mview_name like '&1')
AND	(('&1' IS NULL OR '&2' IS NOT NULL) OR (OWNER=:OWNER AND MVIEW_NAME LIKE '&1'))
-- if both &1 and &2 are null then owner = :owner
AND (('&1' IS NOT NULL) OR (OWNER = :OWNER))
ORDER BY OWNER, MVIEW_NAME
;

UNDEF 1
UNDEF 2
