# Importante data

## List
- TOTAL_CONNECTIONS
- CONCURRENT_CONNECTIONS
- BUSY_TIME
- CPU_TIME
- ROWS_SENT
- REQUEST_TIME

## Config to get indicater


### Config my.cnf

in /etc/mysql/my.cnf
add

```bash
[mariadb]
userstat = 1
plugin_load_add = query_response_time
slow_query_log
slow_query_log_file=/var/log/mysql/mariadb-slow.log
long_query_time=5.0
log_queries_not_using_indexes=ON
min_examined_row_limit=100000
log_slow_admin_statements=ON
```
 and retart service mariadb

### Add variable

```sql
INSTALL SONAME 'query_response_time';
SET GLOBAL userstat=1;
SET GLOBAL slow_query_log_file 'mariadb-slow.log';
SET GLOBAL long_query_time=5.0;
```


### Show statistics

```sql
SELECT * FROM INFORMATION_SCHEMA.USER_STATISTICS\G
SELECT * FROM INFORMATION_SCHEMA.QUERY_RESPONSE_TIME;
```


### FILE LOG

```bash
cat /var/log/mysql/mariadb-slow.log
```
