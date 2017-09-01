# sqlplus-commands
Bash-like commands in sqlplus for browsing Oracle Data Dictionary.

I had once no choice but to use SQL*Plus and I created a set of scrtips which
helped me navigate around Oracle Data Dictionary in everyday work. 

## Features

List tables, views, triggers, user, etc. Unix-like prompt which shows 
user, database instance that you are logged on to and also the current schema.

```
system@XE SYSTEM> -- list tables in current schema
system@XE SYSTEM> @lstab
system@XE SYSTEM>
system@XE SYSTEM> -- list tables in HR schema where table name starts wiht 'JOB'
system@XE SYSTEM> @lstab HR JOB%
```

Get details about a table.
```
system@XE SYSTEM> -- list constraints
system@XE SYSTEM> @tcc HR JOB_HISTORY
system@XE SYSTEM>
system@XE SYSTEM> -- list foreign keys
system@XE SYSTEM> @tfk HR JOB_HISTORY
```

Get details about table partitions.
```
system@XE SYSTEM> -- what partions and aprtition columns table has
system@XE SYSTEM> @tpt SYSTEM LOGMNR_OBJ$
system@XE SYSTEM>
system@XE SYSTEM> -- list all table partitions
system@XE SYSTEM> @tpts SYSTEM LOGMNR_OBJ$
```

Change current schema and other scripts make use of it.
```
system@XE SYSTEM> @owner
SYSTEM
system@XE SYSTEM> @owner HR
system@XE HR> @lstab

OWNER                TABLE_NAME                     TABLESPACE_NAME                STATUS     PARTITIONED TEMPORARY
-------------------- ------------------------------ ------------------------------ ---------- ----------- ---------
HR                   COUNTRIES                                                     VALID      NO          N
HR                   DEPARTMENTS                    USERS                          VALID      NO          N
HR                   EMPLOYEES                      USERS                          VALID      NO          N
HR                   JOB_HISTORY                    USERS                          VALID      NO          N
HR                   JOBS                           USERS                          VALID      NO          N
HR                   LOCATIONS                      USERS                          VALID      NO          N
HR                   REGIONS                        USERS                          VALID      NO          N

7 rows selected.

```

Customized login script which sets various sqlplus parameters to reasonable values, 
sets default NLS_%_FORMAT parameters, etc.
```
IDLE> connect system
Enter password:
Connected.

      SID   SERIAL#    AUDSID
--------- --------- ---------
      139       473    402515
Session trace file: C:\oracle\oraclexe112\app\oracle\diag\rdbms\xe\xe\trace\xe_ora_11572.trc
system@XE SYSTEM>
```

## Installing

Place all the scripts into a directory which is the current working directory when starting SQL*Plus.



