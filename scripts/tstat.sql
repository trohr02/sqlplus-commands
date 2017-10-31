/*
Author: Tomas Rohr, rohr.tomas@gmail.com
Last change date: 2017-10-30
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
COLUMN TABLE_NAME FORMAT A30
COLUMN NUM_ROWS FORMAT 999G999G999G999
COLUMN AVG_ROW_LEN FORMAT 999G999G999
COLUMN SAMPLE_PCT FORMAT A4
COLUMN LAST_ANALYZED FORMAT A10

SELECT
    OWNER 
   ,TABLE_NAME
   ,NUM_ROWS
   ,AVG_ROW_LEN
   ,TO_CHAR(LAST_ANALYZED,'YYYY-MM-DD') AS LAST_ANALYZED
   ,CASE WHEN NUM_ROWS <> 0 
      THEN TO_CHAR(SAMPLE_SIZE / NUM_ROWS * 100) || '%'
    END AS SAMPLE_PCT
FROM ALL_TAB_STATISTICS
WHERE OBJECT_TYPE = 'TABLE'
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
