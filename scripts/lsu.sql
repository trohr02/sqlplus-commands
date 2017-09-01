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
SET FEEDBACK OFF
SELECT NULL "1" FROM DUAL WHERE 1=0;
SET FEEDBACK ON

COLUMN USERNAME FORMAT A30
COLUMN USER_ID FORMAT 999999999999

SELECT
     USERNAME
    ,USER_ID
FROM ALL_USERS
WHERE ('&1' IS NULL OR USERNAME LIKE '&1')
ORDER BY 1
;

UNDEF 1
