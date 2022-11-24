## install cron
```sql
apt install cron
```

## Change config Cron
```bash
nvim /etc/crontab
```

or

```bash
nano /etc/contab
```

```bash
*/2 *  * * *    root   mysqldump -u <user> --port=3306 -h <ip-container>  -p'<password>' dabass > /<where save>/dump.sql
```

## recuperation data

```bash
mysql --user='<user>' --password='<password>' dabass < /<where save>/dump.sql
```


