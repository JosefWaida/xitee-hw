#!/bin/bash

# Set environment variables
DB_CONTAINER_NAME=${DB_CONTAINER_NAME}
WP_CONTAINER_NAME=${WP_CONTAINER_NAME}
DB_USER=${DB_USER}
DB_PASSWORD=${DB_PASSWORD}
DB_NAME=${DB_NAME}
BACKUP_DIR=${BACKUP_DIR}
DATE=$(date +'%Y-%m-%d_%H-%M-%S')
BACKUP_FILE="${BACKUP_DIR}/backup_${DATE}.tar.gz"

# Create backup directory if not exists
mkdir -p ${BACKUP_DIR}

# Dump database
docker exec ${DB_CONTAINER_NAME} mysqldump -u${DB_USER} -p${DB_PASSWORD} ${DB_NAME} > ${BACKUP_DIR}/db_backup_${DATE}.sql

# Copy WordPress files
docker cp ${WP_CONTAINER_NAME}:/var/www/html ${BACKUP_DIR}/wp_files_${DATE}

# Create a compressed archive
tar -czf ${BACKUP_FILE} -C ${BACKUP_DIR} db_backup_${DATE}.sql wp_files_${DATE}

# Remove temporary files
rm ${BACKUP_DIR}/db_backup_${DATE}.sql
rm -rf ${BACKUP_DIR}/wp_files_${DATE}

# Delete backups older than 2 days
find ${BACKUP_DIR} -type f -mtime +2 -name '*.tar.gz' -exec rm {} \;



