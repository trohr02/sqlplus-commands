/*
Author: Tomas Rohr, rohr.tomas@gmail.com
Last change date: 2017-09-01
*/

/*
Do not prompt for substitution variables values.
Use null as default value for substitution variable.
*/
COLUMN 1 NEW_VALUE 1
SET FEEDBACK OFF
SELECT NULL "1" FROM DUAL WHERE 1=0;

BEGIN
    IF '&1' IS NULL THEN
        DBMS_OUTPUT.PUT_LINE(:OWNER);
    ELSE
	   :OWNER := UPPER('&1');
	   EXECUTE IMMEDIATE 'ALTER SESSION SET CURRENT_SCHEMA='||:OWNER;
    END IF;
END;
/


UNDEF 1
SET FEEDBACK ON
