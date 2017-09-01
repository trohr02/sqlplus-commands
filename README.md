# sqlplus-commands
Bash-like commands in sqlplus for browsing Oracle Data Dictionary.

I had once no choice but to use SQL*Plus and I created a set of scrtips which
helped me navigate around Oracle Data Dictionary in everyday work. 

See the documentation on the [wiki](https://github.com/trohr02/sqlplus-commands/wiki).

## Features

- List tables, views, triggers, packages, user, etc. 
- Unix-like prompt which shows user and database instance that you are logged on to and also the current schema.
- Customized login script

### Examples

List all shemas/owners.
```
system@XE SYSTEM> @lsu

USERNAME                             USER_ID
------------------------------ -------------
ANONYMOUS                                 35
APEX_PUBLIC_USER                          45
APEX_040000                               47
APPQOSSYS                                 30
CTXSYS                                    32
DBSNMP                                    29
DIP                                       14
FLOWS_FILES                               44
HR                                        43
MDSYS                                     42
MONEY                                     49
ORACLE_OCM                                21
OUTLN                                      9
SYS                                        0
SYSTEM                                     5
XDB                                       34
XS$NULL                           2147483638

6 rows selected.
```

List tables in current schema
```
system@XE SYSTEM> @lstab

OWNER                TABLE_NAME                     TABLESPACE_NAME                STATUS     PARTITIONED TEMPORARY
-------------------- ------------------------------ ------------------------------ ---------- ----------- ---------
SYSTEM               AQ$_INTERNET_AGENT_PRIVS       SYSTEM                         VALID      NO          N
SYSTEM               AQ$_INTERNET_AGENTS            SYSTEM                         VALID      NO          N
SYSTEM               AQ$_QUEUES                     SYSTEM                         VALID      NO          N
SYSTEM               AQ$_QUEUE_TABLES               SYSTEM                         VALID      NO          N
SYSTEM               AQ$_SCHEDULES                  SYSTEM                         VALID      NO          N
SYSTEM               DEF$_AQCALL                    SYSTEM                         VALID      NO          N
SYSTEM               DEF$_AQERROR                   SYSTEM                         VALID      NO          N
```

List tables in SYS schema which have 'MESSAGE' in the name.
```
system@XE SYSTEM> @lstab SYS %MESSAGE%

OWNER                TABLE_NAME                     TABLESPACE_NAME                STATUS     PARTITIONED TEMPORARY
-------------------- ------------------------------ ------------------------------ ---------- ----------- ---------
SYS                  AQ$_MESSAGE_TYPES              SYSTEM                         VALID      NO          N
SYS                  AQ$_PENDING_MESSAGES           SYSTEM                         VALID      NO          N
SYS                  STREAMS$_APPLY_SPILL_MESSAGES  SYSAUX                         VALID      NO          N
SYS                  STREAMS$_MESSAGE_CONSUMERS     SYSTEM                         VALID      NO          N
SYS                  STREAMS$_MESSAGE_RULES         SYSTEM                         VALID      NO          N
SYS                  WRI$_ADV_MESSAGE_GROUPS        SYSAUX                         VALID      NO          N
```

Change current schema and other scripts make use of it.
```
system@XE SYSTEM> @owner
SYSTEM
system@XE SYSTEM> @owner HR
system@XE HR>
```

List views 
```
system@XE HR> @lsv

OWNER                VIEW_NAME                      READ_ONLY
-------------------- ------------------------------ ---------
HR                   EMP_DETAILS_VIEW               Y
```

Get details about table partitions.
```
system@XE SYSTEM> @tpt SYSTEM LOGMNR_OBJ$

OWNER                NAME                           COLUMN_NAME                             P
-------------------- ------------------------------ ------------------------------ ----------
SYSTEM               LOGMNR_OBJ$                    LOGMNR_UID                              1

1 row selected.


PARTITION_NAME                 HIGH_VALUE                                            NUM_ROWS LAST_ANA
------------------------------ -------------------------------------------------- ----------- --------
P_LESSTHAN100                  100                                                          0 29.05.14

1 row selected.
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



