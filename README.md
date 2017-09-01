# sqlplus-commands
Bash-like commands in sqlplus for browsing Oracle Data Dictionary.

I have once no choice but to use SQL*Plus and I created a set of scrtips which
helped me navigate around Oracle Data Dictionary in everyday work. 

## Features

List tables, views, triggers, user, etc.
```
> -- list tables in current schema
> @lstab
>
> -- list tables in HR schema where table name starts wiht 'JOB'
> @lstab HR JOB%
```

Get details about a table.
```
> -- list constraints
> @tcc HR JOB_HISTORY
>
> -- list foreign keys
> @tfk HR JOB_HISTORY
```

Get details about table partitions.
```
> -- what partions and aprtition columns table has
> @tpt SYSTEM LOGMNR_OBJ$
>
> -- list all table partitions
> @tpts SYSTEM LOGMNR_OBJ$
