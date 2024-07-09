#!/bin/bash

# Backup WordPress database
mysqldump -u exampleuser -p examplepass -h db exampledb > /backups/db_backup_$(date +%Y-%m-%d_%H-%M-%S).sql

# Backup WordPress files
tar -czf /backups/wordpress_backup_$(date +%Y-%m-%d_%H-%M-%S).tar.gz -C /var/www/html .

# Archive backups older than two days
find /backups -name 'db_backup_*' -o -name 'wordpress_backup_*' -mtime +2 -exec rm {} \;
