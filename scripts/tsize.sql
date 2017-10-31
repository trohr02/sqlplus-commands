/*
Author: Tomas Rohr, rohr.tomas@gmail.com
Last change date: 2017-10-30
*/
SET VERIFY OFF

/*
Do not prompt for substitution variables values.
Use null as default value for substitution variable.
*/
COLUMN 1 NEW_VALUE 1
COLUMN 2 NEW_VALUE 2
SET FEEDBACK OFF
SELECT NULL "1", NULL "2", NULL "3" FROM DUAL WHERE 1=0;
SET FEEDBACK ON

COLUMN OWNER FORMAT A20
COLUMN TABLE_NAME FORMAT A30
COLUMN MB FORMAT 999G999G999G990D9
COLUMN BLOCKS FORMAT 999G999G999G990
COLUMN SEGMENT_TYPE FORMAT A20

SELECT
   OWNER
  ,SEGMENT_NAME AS TABLE_NAME
  ,SUM(BYTES)/1024/1024 AS MB
  ,SUM(BLOCKS) AS BLOCKS
  ,SEGMENT_TYPE
FROM DBA_SEGMENTS
WHERE SEGMENT_TYPE in ('TABLE', 'TABLE PARTITION', 'TABLE SUBPARTITION')
-- if both &1 and &2 are not null then (owner like '&1' and SEGMENT_NAME like '&2')
AND (('&1' IS NULL OR '&2' IS NULL) OR (OWNER LIKE '&1' AND SEGMENT_NAME LIKE '&2'))
-- if &1 is not null and &2 is null then (owner=:owner and SEGMENT_NAME like '&1')
AND	(('&1' IS NULL OR '&2' IS NOT NULL) OR (OWNER=:OWNER AND SEGMENT_NAME LIKE '&1'))
-- if both &1 and &2 are null then owner = :owner
AND (('&1' IS NOT NULL) OR (OWNER = :OWNER))
GROUP BY 
   OWNER
  ,SEGMENT_NAME
  ,SEGMENT_TYPE
ORDER BY OWNER, SEGMENT_NAME
;

UNDEF 1
UNDEF 2
