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
COLUMN PRIVLIST FORMAT A50

SELECT
	OWNER, TABLE_NAME,
	LISTAGG(PRIVILEGE, ',') WITHIN GROUP (ORDER BY PRIVILEGE) AS PRIVLIST
FROM (
	SELECT DISTINCT
		OWNER, TABLE_NAME,
		DECODE(PRIVILEGE,'SELECT','S','UPDATE','U','INSERT','I','DELETE','D','ALTER','A','FLASHBACK','F',
		 'READ','R', 'QUERY REWRITE', 'QR', 'ON COMMIT REFRESH', 'OCOMR',
		 'DEBUG', 'DBG', 'EXECUTE', 'E', PRIVILEGE) AS PRIVILEGE
	FROM (
		SELECT TABLE_SCHEMA AS OWNER, TABLE_NAME, PRIVILEGE
		FROM
			ALL_TAB_PRIVS
		WHERE 
        -- if both &1 and &2 are not null then (owner like '&1' and table_name like '&2')
            (('&1' IS NULL OR '&2' IS NULL) OR (TABLE_SCHEMA LIKE '&1' AND TABLE_NAME LIKE '&2'))
	)
)
GROUP BY OWNER, TABLE_NAME
ORDER BY OWNER, TABLE_NAME
/

UNDEF 1
UNDEF 2
